/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.flowable.eventregistry.impl;

import java.util.Collection;
import java.util.Map;

import org.flowable.eventregistry.api.CorrelationKeyGenerator;
import org.flowable.eventregistry.api.EventRegistry;
import org.flowable.eventregistry.api.EventRegistryEvent;
import org.flowable.eventregistry.api.EventRegistryEventConsumer;
import org.flowable.eventregistry.api.InboundEventProcessor;
import org.flowable.eventregistry.api.OutboundEventProcessor;
import org.flowable.eventregistry.api.runtime.EventInstance;
import org.flowable.eventregistry.model.InboundChannelModel;

/**
 * @author Joram Barrez
 */
public class DefaultEventRegistry implements EventRegistry {

    protected EventRegistryEngineConfiguration engineConfiguration;

    protected CorrelationKeyGenerator<Map<String, Object>> correlationKeyGenerator;

    protected InboundEventProcessor inboundEventProcessor;
    protected OutboundEventProcessor outboundEventProcessor;

    public DefaultEventRegistry(EventRegistryEngineConfiguration engineConfiguration) {
        this.engineConfiguration = engineConfiguration;
        this.correlationKeyGenerator = new DefaultCorrelationKeyGenerator();
    }

    @Override
    public void setInboundEventProcessor(InboundEventProcessor inboundEventProcessor) {
        this.inboundEventProcessor = inboundEventProcessor;
    }

    @Override
    public void setOutboundEventProcessor(OutboundEventProcessor outboundEventProcessor) {
        this.outboundEventProcessor = outboundEventProcessor;
    }

    @Override
    public void eventReceived(InboundChannelModel channelModel, String event) {
        inboundEventProcessor.eventReceived(channelModel, event);
    }
    
    @Override
    public void sendEventToConsumers(EventRegistryEvent eventRegistryEvent) {
        Collection<EventRegistryEventConsumer> engineEventRegistryEventConsumers = engineConfiguration.getEventRegistryEventConsumers().values();
        for (EventRegistryEventConsumer eventConsumer : engineEventRegistryEventConsumers) {
            eventConsumer.eventReceived(eventRegistryEvent);
        }
    }

    @Override
    public void sendEventOutbound(EventInstance eventInstance) {
        outboundEventProcessor.sendEvent(eventInstance);
    }

    @Override
    public void registerEventRegistryEventBusConsumer(EventRegistryEventConsumer eventRegistryEventBusConsumer) {
        engineConfiguration.getEventRegistryEventConsumers().put(eventRegistryEventBusConsumer.getConsumerKey(), eventRegistryEventBusConsumer);
    }
    
    @Override
    public void removeFlowableEventConsumer(EventRegistryEventConsumer eventRegistryEventBusConsumer) {
        engineConfiguration.getEventRegistryEventConsumers().remove(eventRegistryEventBusConsumer.getConsumerKey());
    }

    @Override
    public String generateKey(Map<String, Object> data) {
        return correlationKeyGenerator.generateKey(data);
    }

}
