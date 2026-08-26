Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE7C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 07:42:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D06704026D;
	Wed, 26 Aug 2026 09:42:29 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 48DCB400EF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 09:42:28 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 64BC77A00CC;
 Wed, 26 Aug 2026 03:42:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 03:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787730147;
 x=1787816547; bh=rqqAR6wZNZ2teQzozg5qsV4tmROjNVbZ8KQYP9oWPKg=; b=
 CmWgjsDZ+0jz+SKyLn9UKn8eeuckCaej0xD9cfsEusR/Bo8N6yxE4qNa7gCdWKpv
 mDjVjAE4fw1oFFWYrAYLjvkzIJvyVGI0ZPwwwEFFPWpnHS/L5bF4nbcp/sZ4Hpl5
 1ANUBQoa5oSjKkIh5QDdHwA+RF815H6ggbE/nJLJevVMMHW+HLVj0CE4xH1yOa10
 23ApJj6XuMvBAtLw+Bjl6GpHNXkudQCPGB4CFasuXiFgR6VvL0k0UQVqs7WkvhMx
 W0TkIck4EQtgJHUI4Lo9Yc0dXWf8wvnFJ69AYhl+2uHC9MM1KMYjPuAugq3ZvUIf
 kpdXJMeDoP31JNLPaqJKbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787730147; x=
 1787816547; bh=rqqAR6wZNZ2teQzozg5qsV4tmROjNVbZ8KQYP9oWPKg=; b=a
 /WnyYH2uzMJxAM5psnmGviWLWHcU29phDVoclhowvR7Hp6+j+NVfQbqdp8BJRHhh
 vjgnW274e83EjtM9Y3vrFdSauooIi7H+i88lxicB9L2mVAd5h4YfPKrmXYpgDeBL
 N0Tzi6dua9a1MWh9MGCG21T6uFUoLyzMcIhKYn6G95hZM/NfJuBERGA/eNw9fmYF
 c45keZnIMt3PiwrtYMDqOPlaylKI301oJrxTWZuvRP/m0ZmtShY6eJFIHB9xnxKN
 EUkpS02KdBhcUxTl/YEEIbNKsY76BLM5ssnFaYH7/14EQBbLOqvP7HOiGM/JPUDb
 JZ/romv9ymJ6meV+hUZ1g==
X-ME-Sender: <xms:4piOaiO0ubPn8KKVm3TaeG11qv60NGEGn4CtzVE_v2MZJNDT97Gwyw>
 <xme:4piOal7audXogsjh7LpJ2fT__nt2BOosnZQCE9XxCmRRIApqtlBu1DcrI7NH9MDQH
 j6Vwlw4CqpHaE7EF-0Dn67JmgPqxtv--_j424uNSoIM677FzTnf>
X-ME-Received: <xmr:4piOatidek7fEp9hKrdJ2a1BLogEolt2p93EYxCeo5nQOYSuv5NrL1_NxUrXIeRdrkI27iRgvK5O-M8CB8DUJwbkdA>
X-ME-Proxy-Cause: dmFkZTGDoVZVKGOP7fO5O3BYdzGmum3DiwakJmjjb9tO+6qmReDScVbPXDQ7c9qafZunV2
 HoqjHB+/OMeRxxFMpHXwv/NjL/XW68I6ArEbneZBaTDuai+p/f9gBGpv4R1ZsxDAPzSISx
 RZm13P+zrPTeMkuMJppb2+w+R2xtroYxolWCqzDlKr5+Z23pXi03AlRtq1fLa6F0juLoBh
 6fKeHYYr1d3JTPRbAD+RYUUig6ETDkchF//YJYykuz+mQZPg1KUQfE8ncbNK1qsUMeGeDW
 iElLSLKQhXZF4pr+WMhqzOn/M6/AptaukgNk4U2s0cHTWh7AMqBSL1362JpPPuWAtlXqT+
 GznrzHMwERAIDbVRyKs3tIEakmq8L0Ue3jGc0a7wEjfk5YXVSWMg98Uc6E7Arm4cE211id
 Ktvvp1AE/NutmGjvHfs6wBMRdzX2n2C27mfR8oW3t7yKiyoTC9UQS+npoSgEzV6+1iBIHv
 CwT3uyeHlICr2oAxyRXTxBWcKCqcsMtGBFhIm8Z6pmItPwZVnpH+Tvyluh6E+nRMhV9bTZ
 pVWwRbTC8E+oMfHGsyFB0VlyXVGVtCAOxMzyVHooRTn28rG83240XFSG4f4Ado6b7480yf
 WxQpd0nQsWXsPIEhpX11Y8XhMexfIeYUtiaNJCM2N2BrKFY/4GF2RL//Mh4g
X-ME-Proxy: <xmx:4piOaif7xngkiD4G6tiMJ8INQkNpmmRBPQ4TzgpCkhu4NWbaADaFEg>
 <xmx:4piOatz1WFXMkTBrfNonqcPjqfBKmZKgZQd2GOuO31W2AWnr1zgm2g>
 <xmx:4piOap09YCqkJU9X8XCFhOalJjOL1RaABcHRjBfZIKcaTOraX_sDnw>
 <xmx:4piOaryCt-ipJhJlFq7D6HVkgwp_ISOZzgeHst2mcoqdFkqmksZpIg>
 <xmx:45iOanuNabnZgG4hMj-62JEVPxMPBJbTNAeoSQXe7lq0zEw8v-xwI28z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 03:42:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrew Bailey <abailey@iol.unh.edu>, Dillon Ladd <dladd@iol.unh.edu>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Akhil Goyal <gakhil@marvell.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: Re: DTS performance test coverage question
Date: Wed, 26 Aug 2026 09:42:24 +0200
Message-ID: <83Vdy0w4QXyvRpBjrVDrcQ@monjalon.net>
In-Reply-To: <CABJ3N2UDCcJe9uJd-FV_1khiKy0PWy4_H69jd=FdqaHKb1vYfQ@mail.gmail.com>
References: <CABJ3N2UDCcJe9uJd-FV_1khiKy0PWy4_H69jd=FdqaHKb1vYfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Hello,

13/08/2026 16:28, Andrew Bailey:
>     As of now in DTS, the current options for performance tests are limited
> to single core forward
> performance and cryptodev throughput testing. There are a number of
> performance tests in
> old DTS that we were looking at using to potentially broaden the amount of
> DTS supported
> performance tests.
> 
>     The question to the community is, are there additional performance
> tests in old DTS that would
> be beneficial to port to new DTS?
> 
>     Furthermore, are there performance tests that are desired that do not
> yet have a dedicated test suite
> in old or new DTS?
> 
> For example, some test suites we were looking at as potential candidates
> include:
>  * virtio_perf_cryptodev_func
>  * eventdev_pipeline_perf
>  * rx_timestamp_perf
>  * pvp_multi_paths_virtio_single_core_performance
>  * pvp_multi_paths_vhost_single_core_performance

Some techboard members asked to work on:

	* eventdev_pipeline_perf
	* pvp_multi_paths_virtio_single_core_performance
	* pvp_multi_paths_vhost_single_core_performance

We can skip virtio-crypto and Rx timestamp perf testing.

Thank you


