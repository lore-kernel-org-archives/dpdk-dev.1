Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6640C79FAD
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5324026F;
	Mon,  5 Jan 2026 18:38:36 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 0DE6D40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:38:34 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so1353145e9.2
 for <dev@dpdk.org>; Mon, 05 Jan 2026 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767634714;
 x=1768239514; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDoIQoD4MJN1ti3jRGocEieDLDypqVeVeQ+PN74MgWU=;
 b=Y0NUAkw0vTlrQoyzvn5vyLZVSJvHzTBRtKpqmsdbX4HNh4Hr5Rmn8AgM7tJEmfkWpa
 P1Lnwv+f7ADJN3q1m/ehFaZM0nvujcYCCP39kFc1ZyBgcXYuGsIeohJUnZmFJim5YLh2
 O9Jh40LsysymT5UJhMz69WelUS+GEtlRXGegAordf3gwUCftbuJECKCTnvQodm/wFLg/
 uEuAn6f9vAokVO10Pu9G1hd+GZilgJvjWnsyL3dwh4VQ1VOXDxQJIJPV+0qdcEFVx/F0
 4UiNPDFrRrQ3RYCHJCoaJvZJoIhhZTdGD7ruQQjqRmQeN0nj36UStcWEKE7lfodT4PvP
 qYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767634714; x=1768239514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zDoIQoD4MJN1ti3jRGocEieDLDypqVeVeQ+PN74MgWU=;
 b=BRb7ZuQIXhhu8RrOBIJHHfQ/IIO5Id00CorBtc0RhurIw1Ux4DDK21qzL66ybK8tU4
 msN8u8XjzysECbyXkR7KD2VCVaqyRSubyC4IeyXNEYIWcY+tlvnqwIe5O6auC/Qe8eU9
 Z+uTGw3AJVvHMTCK7VpJ1tjDovUpDOh9DMN8NZamAX1Sf5nZovuS1fPmSI75MgbrQWPT
 52CD0tRRSssG86VPJ7tTgN/K39V8XziNd+VYBe9hZjhITdEVS9wdDOUxM6qTu69ctWFG
 YtaJl2OyoiRqZm4KxbSCrSepIJtc3G4tpp3McihgRsV/a8CVIgkrzfUmmIfqY0rJ8vGy
 s+hw==
X-Gm-Message-State: AOJu0YxTZujMQYIOHsE0iCJuCWOeNaSoZZCrx194MfRCzupK4QNcm/T8
 UatoPEe5LGb+8nhAtX58giSol+Fs4UDRuenf4ILKpalTJLzjHcxZRAad4dW56gaO1SEU1QZo75j
 eXPxMXU8=
X-Gm-Gg: AY/fxX46EbO0tKHpq0zlk8M0/jhjwJMWeee6utQtQhEdtdtNXh/gsKOyCOhZIwQJVrh
 endupxs15xUGgXFYeUGXsP7xiFoILfYjYZLWM7js7MYgKpta+xtIuR5heb/8VJndLk9IUvZT3WY
 XJa9POKxDVbrm/OjiTVsFIxSw8ztFur8HSlObqlvwNvzOxbSDkgG+zhflxhQzuSSF6lSVwviSj+
 VfVCjuzQWhf7SCEEV6eNVQ1LILDIa/YIYK+bm5oyVX7TjDlER4czxJyd+SaiUuecqL2n+emFsA1
 HXjuO2D0eEap6iOoVAVnjVsDS6YMw/KDtrKKxjV+aNs+0avqlwTTcDoyiEFWlJlC7/QQWH3B21l
 KPvFj50hsFhGPi++REFmreP37+LGdIr7PlqJH7Mnjw3hwz1UJYfgc4QSEGfMya2+58L4jNwIlwu
 XkOHPQI42TXmC8zlgwfFW2vOOHAIHoOXRckdVN9g9uEk66TH+FczpS
X-Google-Smtp-Source: AGHT+IGsqgLdrjtnpLAsNjJRwKwWgoQp8gezG/gh+nArdxe3F1nxLgQuI1BGrjHGdllpDuQNsfClOw==
X-Received: by 2002:a05:600c:a108:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-47d7f36e2abmr151115e9.14.1767634714239; 
 Mon, 05 Jan 2026 09:38:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6c08ef66sm59996275e9.10.2026.01.05.09.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 09:38:34 -0800 (PST)
Date: Mon, 5 Jan 2026 09:38:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] test: add a test for null PMD
Message-ID: <20260105093828.4caee2f5@phoenix.local>
In-Reply-To: <7957b0215b1d41cbbc7fc5e52919f0da@huawei.com>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <7957b0215b1d41cbbc7fc5e52919f0da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Mon, 5 Jan 2026 14:49:41 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:
> Thank you for doing this. Having tests for things like this is important both 
> to make sure they work and as a form of documentation.
> 
> In my humble opinion we should not approach this mechanically though, which is 
> what AI tools tend to do. It is usually said that tests should test desired 
> behavior, not specific implementation. Particularly in settings some of the 
> values might not matter, or the whole range might be acceptable, in other cases 
> current implementation might be questionable and by writing a test we just 
> legitimize it.
> 
> Please more see comments inline.

I did not see anything obviously wrong with the tests that it generated so
far. And coverage is more important on legacy code.

> > diff --git a/app/test/test_pmd_null.c b/app/test/test_pmd_null.c
> > new file mode 100644
> > index 0000000000..ebc2447c6d
> > --- /dev/null
> > +++ b/app/test/test_pmd_null.c
> > @@ -0,0 +1,827 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(c) 2026 Stephen Hemminger
> > + */
> > +
> > +#include <inttypes.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +
> > +#include <rte_bus_vdev.h>
> > +#include <rte_cycles.h>
> > +#include <rte_ethdev.h>
> > +#include <rte_ether.h>
> > +#include <rte_lcore.h>
> > +#include <rte_mbuf.h>
> > +#include <rte_mempool.h>  
> 
> I do not think it is a problem, but just curious: how does test_pmd_ring.c 
> manage to use much fewer includes?

I tend to run the tool iwyu on the generated code. This gives a more correct
set of includes without implied includes.

> > +/* Test device names */
> > +#define NULL_DEV_NAME "net_null_test"
> > +
> > +static struct rte_mempool *mp;
> > +static uint16_t port_id = RTE_MAX_ETHPORTS;
> > +static bool port_created;
> > +static bool port_started;  
> 
> // snip setup and teardown functions, could find nothing to nitpick there

The code is exercising device in multiple ways so it didn't seem to need them.
Would be better to avoid global variables though. Like the mempool should
be set in setup.

> Default packet size repeats a few times in this file, can we have a global
> constant for it?
> 
> > +		TEST_ASSERT(bufs[i]->pkt_len == 64,
> > +			    "Unexpected pkt_len: %u", bufs[i]->pkt_len);
> > +		TEST_ASSERT(bufs[i]->data_len == 64,
> > +			    "Unexpected data_len: %u", bufs[i]->data_len);
> > +	}
> > +

Right test should use RTE_ETHER_MIN_LEN

> > +	/* Allocate mbufs for TX */
> > +	for (i = 0; i < BURST_SIZE; i++) {
> > +		bufs[i] = rte_pktmbuf_alloc(mp);
> > +		TEST_ASSERT(bufs[i] != NULL, "Failed to allocate mbuf");
> > +		bufs[i]->data_len = 64;
> > +		bufs[i]->pkt_len = 64;  
> 
> It would help to test sending packets of various sizes, especially spanning 
> multiple buffers or allocating them at the edge of buffer. May even uncover 
> some bugs in the copy mode implementation ;)

Good point.
The copy mode is making several assumptions already and I see bugs there.
It is confusing dummy_packet as mbuf versus data.


The test and the driver should also test multi-segments.

> > +	/* After start, link should be UP */
> > +	TEST_ASSERT(link.link_status == RTE_ETH_LINK_UP,
> > +		    "Expected link UP after start");
> > +	TEST_ASSERT(link.link_speed == RTE_ETH_SPEED_NUM_10G,
> > +		    "Expected 10G link speed");  
> 
> I am not sure it is important to test that the link speed is exactly 10G. Will 
> it be a bug if it becomes 25G tomorrow? Probably any valid value would do.

It is a dummy driver, speed really doesn't matter and should probably be ignored.

> > +static int
> > +test_null_dev_info(void)
> > +{
> > +	struct rte_eth_dev_info dev_info;
> > +	int ret;
> > +
> > +	ret = rte_eth_dev_info_get(port_id, &dev_info);
> > +	TEST_ASSERT(ret == 0, "Failed to get device info");
> > +
> > +	/* Verify expected device info values */
> > +	TEST_ASSERT(dev_info.max_mac_addrs == 1,
> > +		    "Expected max_mac_addrs=1, got %u", dev_info.max_mac_addrs);
> > +	TEST_ASSERT(dev_info.max_rx_pktlen == (uint32_t)-1,
> > +		    "Unexpected max_rx_pktlen");  
> 
> Why is (uint32_t)-1 is a valid packet length for this device? Can at actually 
> accept them?

This is awkward way of saying UINT32_MAX.
And it means the driver has no limit on what the receive buffer might be.
This is not really right it does have limits based on the device flags.

> 
> > +	TEST_ASSERT(dev_info.min_rx_bufsize == 0,
> > +		    "Expected min_rx_bufsize=0, got %u", dev_info.min_rx_bufsize);
> > +
> > +	/* Check TX offload capabilities */
> > +	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MULTI_SEGS,
> > +		    "Expected MULTI_SEGS TX offload capability");  
> 
> It sure sets these values, but are they correct values, and would anything else 
> be incorrect?

I think test is ok testing for what it expects to work.

> > +/*
> > + * Test: RSS configuration
> > + * Note: RSS requires multi-queue configuration
> > + */
> > +static int
> > +test_null_rss_config(void)
> > +{
> > +	struct rte_eth_dev_info dev_info;
> > +	struct rte_eth_rss_conf rss_conf;
> > +	struct rte_eth_conf port_conf = {0};
> > +	uint8_t rss_key[40];
> > +	uint16_t rss_port;
> > +	const uint16_t num_queues = 2;
> > +	uint16_t q;
> > +	int ret;
> > +
> > +	/* Create a new null device for RSS testing with multiple queues */
> > +	ret = create_null_port("net_null_rss_test", NULL, &rss_port);
> > +	TEST_ASSERT(ret == 0, "Failed to create null port for RSS test");
> > +
> > +	ret = rte_eth_dev_info_get(rss_port, &dev_info);
> > +	TEST_ASSERT(ret == 0, "Failed to get device info");
> > +
> > +	/* Configure with RSS enabled and multiple queues */
> > +	port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
> > +	port_conf.rx_adv_conf.rss_conf.rss_hf = dev_info.flow_type_rss_offloads;
> > +
> > +	ret = rte_eth_dev_configure(rss_port, num_queues, num_queues, &port_conf);
> > +	TEST_ASSERT(ret == 0, "Failed to configure RSS port");
> > +
> > +	for (q = 0; q < num_queues; q++) {
> > +		ret = rte_eth_rx_queue_setup(rss_port, q, RING_SIZE,
> > +					     rte_eth_dev_socket_id(rss_port),
> > +					     NULL, mp);
> > +		TEST_ASSERT(ret == 0, "Failed to setup RX queue %u", q);
> > +
> > +		ret = rte_eth_tx_queue_setup(rss_port, q, RING_SIZE,
> > +					     rte_eth_dev_socket_id(rss_port),
> > +					     NULL);
> > +		TEST_ASSERT(ret == 0, "Failed to setup TX queue %u", q);
> > +	}
> > +
> > +	ret = rte_eth_dev_start(rss_port);
> > +	TEST_ASSERT(ret == 0, "Failed to start RSS port");
> > +
> > +	/* Get current RSS config */
> > +	memset(&rss_conf, 0, sizeof(rss_conf));
> > +	rss_conf.rss_key = rss_key;
> > +	rss_conf.rss_key_len = sizeof(rss_key);
> > +
> > +	ret = rte_eth_dev_rss_hash_conf_get(rss_port, &rss_conf);
> > +	TEST_ASSERT(ret == 0, "Failed to get RSS hash config");
> > +
> > +	/* Update RSS config with new key */
> > +	memset(rss_key, 0x55, sizeof(rss_key));
> > +	rss_conf.rss_key = rss_key;
> > +	rss_conf.rss_key_len = sizeof(rss_key);
> > +	rss_conf.rss_hf = dev_info.flow_type_rss_offloads;
> > +
> > +	ret = rte_eth_dev_rss_hash_update(rss_port, &rss_conf);
> > +	TEST_ASSERT(ret == 0, "Failed to update RSS hash config");
> > +
> > +	/* Verify the update */
> > +	memset(rss_key, 0, sizeof(rss_key));
> > +	rss_conf.rss_key = rss_key;
> > +
> > +	ret = rte_eth_dev_rss_hash_conf_get(rss_port, &rss_conf);
> > +	TEST_ASSERT(ret == 0, "Failed to get RSS hash config after update");
> > +
> > +	/* Verify key was updated */
> > +	for (unsigned int i = 0; i < sizeof(rss_key); i++) {
> > +		TEST_ASSERT(rss_key[i] == 0x55,
> > +			    "RSS key not updated at byte %u", i);
> > +	}
> > +  
> 
> Can we receive and send something from/to these queues and verify resulting 
> statistics? Statistics is one of the most important use cases for the null 
> device, and it does benefit from multi-queue.

Use of RSS in Null PMD is odd. It really doesn't do RSS. It is lying about it.
The packets are never hashed on receive. Looks like it was just a way to exercise
the RSS API's.

My goal is to get some tests for vdev's where there are none now, and fix
some of the obvious wonky stuff in the drivers (like doing stats in odd and
slow ways).


