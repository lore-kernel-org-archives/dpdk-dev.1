Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FAECD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:31:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A476402C3;
	Sat,  6 Jun 2026 01:31:49 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 17AB14028F
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:31:48 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7301914000E4;
 Fri,  5 Jun 2026 19:31:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 19:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780702307;
 x=1780788707; bh=OTfPTbFi7oS50opRAO2rcdFeyCBCtwOe4PmkwspN3WM=; b=
 LxvFwgAVwdfenrv+2J9ZaBVFfbo8kzDRG0tSGN5P7U4LeyMIXXWb55LxK4hnCHKS
 gx4t54MI2PPEnrd9fi7bZZTX7NZIf7nB9kCnrbtLcJaoe3pYnK2yyNFkIw3b8McI
 3duFUUuN8wpk8bbPyIQxS/G30GmNIhBG9OsBD6htUAnknqAlKLIs0CUq4XtXI0n4
 W8mcsP/Ni6Mqm9JWcAh3jQK/MJFtJUrN3iD8a/Lz9hSQjqMZ5lIfDmG9qUMPyArw
 zAzrYcdokmuxVnPaA3Lvk0P4KNz1THM1VEHSEc+yQRL2qEaRo4dCgaIb8qoBLpVH
 GVVfzc6F4f+z0yGiTjS7Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780702307; x=
 1780788707; bh=OTfPTbFi7oS50opRAO2rcdFeyCBCtwOe4PmkwspN3WM=; b=Z
 cCVgmwbZKugEC25emWjhiKBAqXkcNCvnQJRh0DVW64M1vLGM/QHyim5gFdWXllwI
 +GG03WIKQzC5gA/9CX27aacsRRyOIITjdgqKYW9iuhsAm5R/oys2ZsIJRo6gck44
 W4U8jZGQuzjuk+pGzeIju58M4yiL7mtvt3SVa9aoaa7VX/D3ymrMxpyCCZYci7P2
 LnulUFYDYqCq7G5S3vKMf1kn7Plbx4r4mqp/IdKYBjSnmliZVo2I18xt8/5RkXVR
 4dvWOMZOiLpzlp/mD4v3S8kBCBsJgGZThJGoNa2Ac5BUXtCR8Nd/Md1dt5iW4XIl
 EVuJc49xFj7g/TdqAnY9g==
X-ME-Sender: <xms:Ylwjavm-aRV5JsesC4LHZYd_X_dEvrER51BggcL88OXT6GXj-xhwtA>
 <xme:Ylwjai-HtyXaGR18JvzvM4DnUbA4ijjBE5vxYiZVBUO668sLC_yYDfeyCi0KJfUkq
 ttPKVI7LAu3Sb7-Ia3u0pY2CEosTHGcOHaQ4cVR_gNAhIaXWcbgNw>
X-ME-Received: <xmr:YlwjatnSv8GZrDJov4gdANKpKtQpXJQcm_wVEJPvY1NggNunjHFlP_zy8i-pSG4SyZV2eM2WbE4n_GgTzl7SO4D24g>
X-ME-Proxy-Cause: dmFkZTExYLQzzM4dt+PwAXdDLwgcK5ajtUOCAbcB8ndvwPhdjuZosdzGcI+nBgkdu1cN5e
 ojTiFnqpsx/La5AapsRAAzh4FII+dxYTnwTxYDqBBeTInzBZjWxAPcgkxhc4XBK4mPX+e3
 J5Cs+ubQYH05F8EX7j3oEaflwSOpYpc2SPW12LXSo8HQ7auPb4eUc1gKGYnxRScHi4d5+b
 mfRFRHpapYmmg6tyxN8spOe24AMMf+2yK0WDvh2QRJU8/VUNcXrRInBYvJCP3UsAkYJkHk
 hetn/J0XlgkODwLyMVqsykBFz3jNeyKjvxpeyj0J5exPr+mGzhyHNBlRkWMfa8Tc20W3An
 n+GQiZ+X02R+jmEziMsOKKZa5XVPub1PsgBrA0SMQLin4tj0OxReZlGXWP4E5WSqMzBHyB
 +NraMXP22q1LST7zQODARZLMM+JLPqLtOoeK7HpUc+jXCn0GSIpxoyTyGYkCR6OMF4j5kD
 H5+3Mr1RrgS7okkPt++5qs5h2k1esvXuq/gwaesOHd3hqd848cJ2ZIJNdNbOKp16Si2Lcf
 H2wA9/wEjRy/gve1SMzN8LKR7xSoz5u/CN2Q0oF2ZTGFI0mzRB4KSm2WJw3KFOuCZI3NCw
 pbZ2o0euQlPVkZuyATmcHhPJmk40NHVQertVI3T28rOpUdZWldYx1DVrzB2w
X-ME-Proxy: <xmx:Ylwjav18VseXX5xKwyMEEZxLThcaa-YFJ9qmhfU6k5P0oGSTgStvuw>
 <xmx:YlwjaoqTRKH5O2fMJMbNY8WNdZpCOnzjrx84oqwT539igXvuQS5Y0Q>
 <xmx:YlwjasfbGM88-dXiHkhLN_xayzolCRK-Zke8bpMJyiJfpCeZM28qYA>
 <xmx:YlwjanqTv10JG3U4IrHRwD51t60bJ9ni0dsU2FZBNZ7sPXl4y5bRTQ>
 <xmx:Y1wjakzlqdqFiBX92ZcFUUHKa2kjlFjj02d4QISUEbn8c2wCwlolDbv1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:31:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: Re: [PATCH v8 9/9] dts: add selective Rx tests
Date: Sat, 06 Jun 2026 01:31:44 +0200
Message-ID: <M1wcG81tTm6suKdG5I1mHw@monjalon.net>
In-Reply-To: <20260605142815.1aaf727b@phoenix.local>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-10-thomas@monjalon.net>
 <20260605142815.1aaf727b@phoenix.local>
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

Sorry I should have told you that I was working on this today.
I fully agree with the comments you sent as I was fixing it.

I'm going to send a new version which is better reviewed
and properly tested with DTS.

Results
=======
test_suites: PASS
  rx_split: PASS
    selective_rx_all_discard: PASS
    selective_rx_headers: PASS
    selective_rx_headers_discard_length: PASS
    selective_rx_no_offload: PASS
    selective_rx_payload_only: PASS
    selective_rx_segment_exceeds_mbuf: PASS
    selective_rx_two_segments: PASS

Test Cases Summary
==================
SKIP      = 0
PASS      = 7
BLOCK     = 0
FAIL      = 0
ERROR     = 0
PASS RATE = 100%



05/06/2026 23:28, Stephen Hemminger:
> AI review found:
> Patch 9 (dts: add selective Rx tests)
> 
> selective_rx_out_of_range expects a rejection that never happens, so the
> negative test will fail. It configures a real segment plus an oversized
> discard segment:
> 
> 	rx_segments_length=[ETHER_IP_HDR_LEN, 20000],
> 	mbuf_size=[256, 0],
> 
> and expects start_all_ports() to fail. But an over-range length on a discard
> segment is not rejected anywhere: rte_eth_rx_queue_check_split() does
> "continue" for mp == NULL segments, so it never length-checks them, and
> mlx5_rxq_new() clamps it:
> 
> 	if (seg_len > tail_len)
> 		seg_len = qs_seg->mp != NULL ? buf_len - offset : tail_len;
> 
> The discard seg_len becomes the remaining frame length, the queue is built,
> the port starts, and the test hits its fail().
> 
> Clamping an over-long discard to "the rest" is harmless (the bytes are
> discarded anyway), so the cleanest fix is probably to drop or rework this
> test rather than add a rejection path. If rejection is the intended
> contract, it would have to be added for discard segments in patch 2 or
> patch 6 -- a behavior choice, not a correctness requirement.
> 
> Minor: expressing a leading discard as --mbuf-size=0,... puts 0 at index 0,
> and testpmd treats mbuf_data_size[0] as the primary pool size elsewhere (the
> max_rx_pkt_len > mbuf_data_size[0] check, the default mbuf_pool_find(socket,
> 0)). Only bites an unusual config, but it is a latent foot-gun.



