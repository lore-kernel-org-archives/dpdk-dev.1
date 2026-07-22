Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0298C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 20:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9258402E4;
	Wed, 22 Jul 2026 22:14:02 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 3BF5A4027C;
 Wed, 22 Jul 2026 22:14:01 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 917994014F
 for <announce@dpdk.org>; Wed, 22 Jul 2026 22:13:59 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1AF867A006D;
 Wed, 22 Jul 2026 16:13:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 16:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1784751238; x=1784837638; bh=u3wOHXNPvo
 Ahhswz27H/1ktXbSr6jBpWzX9ZWShSad8=; b=ZIX5iXO7YzmeEt5qvPTaBdCpba
 9KRqupyqoyLFjHigN9SwquC57TRJ4koI4KsVrpd2wHbe4nrd0KWBCdZSAl0Y1kX7
 linuK2dKHdNtAiDT+U796A0wGZswcTq6HKF+tISj0m2SqYe/bIsq7D5hUsPIFRA9
 ZUpsqhkzLv3yqog6bvSILrSfOgUiTfO48PbX+qsUCLGkbajSA2PU1nh0C3rzj6KV
 SjS+fjWHYcgT4vZUqXklEv4mEJyXjAjDar1CFPsuRjAJlAN5z9Lod7haE3/CXYCl
 w4ODdNJYOng1bQXRz6nwzzDL0DN/my3tR8n7F78BB77aD32Zpwk/x7nibdyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1784751238; x=1784837638; bh=u3wOHXNPvoAhhswz27H/1ktXbSr6jBpWzX9
 ZWShSad8=; b=mdXLJBHDQwe2KH8zSPp6zyUfWgookUzx5jO19s/vVcj1P24KbmF
 O0NOWh0v2vckc4KUk0+o9LTPTW8F8dKkFziQOWd9C7Eq6ezxspHMO+UdSben/XVb
 fSyT52SMxYRUpu1xuh4C2zkw7XKIXnhZjJPZbWY4qzqxHcJXz8QgS+GK2qc0W5PS
 qZo+eCe5EQLFuzxThCOOr8oGpp1ary5fdwoaXwVAT/W/O7gRuANA38IXInCwu4Hm
 9LvPe3/jAU10UUrgbWLF6B1f1ImG52VxVljabXME78Hclx56zMbrhXf4SE478db8
 y4MQk+/ehfwEAg6WBMcwxRbcAJUgnuaf4TQ==
X-ME-Sender: <xms:hiRhancG58LK-9SdOBQxtZqjcYiV1SU-Y894ZLRXcVTUaPyQ3szNLA>
 <xme:hiRhajE8fibrSTks1ViFfqa6JmWzijqJxU8ovrBWYfTbICLVcrTMeZJPbpYWsZEPd
 nO3y-2dpeBpksd8zHO_qux6eKbre0tDksjvY9L_mQjg9nu2-VCuKQ>
X-ME-Received: <xmr:hiRharlzsNG0dRCKclirK2ytkn-KCUy5yTANw_HBVSf4_n74LZsWumzDj-WPBk2G93-_AiX0DqbhBgVCdrEHgcvKyw>
X-ME-Proxy-Cause: dmFkZTGn8K+rOF46A30++tAip9uguJGChFC5rdp21P/EE6nK/jFNeOAg97I1NyYfhEEu/w
 XYNKymtTmHG5sDWvXLR8IqoxAmioZz7v+Iob3uO7I2Z9XA6c6TX2OQPwUiHA3VzP5NnTa3
 UctxOQwLABTpAyOquKIl9g4usZgXZYFUMU9HH4QjDR32v5AvBT085o7BTtIRaO+hgJEINB
 4QMb0fEdFbjR+FRm4QFbEqXWLCJBbSdcGs5t9Cw+nqG2C7jeHFR1mSCRaIimj+xzNl/PNG
 C8t/RjWllLIAgrOOFAtWMWtJhj6M+jsVN4TnbsUf8WwrcmKgBtKhDsIVepyh8kzWc6NiLu
 r1GdyowylvRssdC7/2Fm8EHAY0aOsccUwzFcryTcNhvaIZSDa9FNqLvShHNxLQ41QuLkfG
 k2qptYfhSh+mf/yAFZevCrnqxWciFfOYYD+iDfE2j0DsWZcQbZINAje+K9ZRwDgUCq8kPG
 +kapyJlzNRIPeCtK847qlrNrpl3eEiVuYhnLUPjftqqu6sX+tipdf3yUfxVX4HaOVLyoKU
 iVKI1H2Mea1P1H08wleAG4t3ByWRe4FNIkuXocWgD79UwzJVE9X2c8pqJUeoCww3mV7qne
 r+EiPMn9OHnNiXh4w2s8rMbmssDIAdWk247sdhSj8jb/haW/AxcxNaGhyGug
X-ME-Proxy: <xmx:hiRhalyQRZOv6NEwbDDyGrRqCKOQTo6kcnOtrEd7ae6AYBzHfksUeA>
 <xmx:hiRhanSKQ436wGX6hC6JuwoIg9v96eZzDECCxn0gcjp7UU547xsx-A>
 <xmx:hiRhaousi3dz937oraO1757lHDwnGQ4JSNpWtLV0OttEiNxOA2S8OQ>
 <xmx:hiRhaptOxp5AhcyhSytdJGIW1AYyfwAbNheisObqHMqKTi00AlEOHg>
 <xmx:hiRhas-qZQ8XoddCO3m6ojMdnI61cNmOrzJAJe1mk8YcFULpOXZUChR_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Wed, 22 Jul 2026 16:13:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK 26.07 released
Date: Wed, 22 Jul 2026 22:13:57 +0200
Message-ID: <nkvYuCbUTBKN7caG89ssLw@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

A new major release is available:
	https://fast.dpdk.org/rel/dpdk-26.07.tar.xz

It was a small release cycle:
	868 commits from 132 authors
	1388 files changed, 99644 insertions(+), 21594 deletions(-)

It is not planned to start a maintenance branch for 26.07.
This version is ABI-compatible with 25.11.

Highlights of 26.07:
	- option --pagesz-mem for per-page-size maximum
	- option --no-auto-probing for no device at init
	- less mempool cache misses in run-to-completion
	- peek style API for staged-ordered ring
	- RISC-V vector paths
	- PTP helpers and clock relay example
	- selective Rx API to save PCI bandwidth
	- vhost memory hotplug
	- pcap driver enhanced
	- LinkData sxe2 NIC driver
	- extended BPF API and hardened validator
	- real-time telemetry watcher
	- AI review helpers

Important note:
	Applications may need to retune their mempool cache size
	after upgrading to DPDK 26.07.

More details in the release notes:
	https://doc.dpdk.org/guides/rel_notes/release_26_07.html


There are 49 new contributors (including authors, reviewers and testers).
Welcome Adam Hassick, Alexey Simakov, Alok Mishra, Andrea Panattoni,
Arin Kharkar, Borys Tsyrulnikov, Chengfei Han, Chenna Arnoori,
Claudia Cauli, Dakota Sicher, Daniil Agalakov, Daniil Iskhakov,
Daphne Priscilla, Dawid Wesierski, Deepthi Kavalur, Denis Lyulin,
Denis Sergeev, Gena Tertychnyi, James Raphael Tiovalen, Jay Wang,
Jie Liu, Kavya AV, Koushik Bhargav Nimoji, Linhu Li, Marcel Telka,
Marek Kasiewicz, Mark Blasko, Mateusz Fryze, Matthew Gee, Maxime Peim,
Md Shofiqul Islam, Michal Sieron, Mukul Katiyar, Ouyang Hao,
Pratik Senapati, Pravin M Bathija, Raghavendra Ningoji, Rayane Boussanni,
Samyak Jain, Shuzo Ichiyoshi, Siraj Luthfi Ananda, Sushmita Hoskeri,
Weijun Pan, Wenqiang Chen, Ye Chen, Zhiguang Jin, Zijian Li,
Zoe Cheimets, and Zongyu Wu.

Below are the top commit counts per employer (with authors count):
	230     Intel (27)
	136     stephen@networkplumber.org (1)
	 62     NVIDIA (8)
	 60     Red Hat (3)
	 54     Marvell (18)
	 48     Huawei (7)
	 32     LinkData (1)
	 31     Free (2)
	 27     Trustnet (1)
	 27     NXP (5)
	 25     Broadcom (8)
	 21     Google (4)
	 14     UNH (3)
	 12     Microsoft (4)
	 10     SmartShare Systems (1)

A big thank to all courageous people who took on the non rewarding task
of reviewing other's job.
Based on Reviewed-by and Acked-by tags, the top non-PMD reviewers are:
     72     Bruce Richardson <bruce.richardson@intel.com>
     48     Konstantin Ananyev <konstantin.ananyev@huawei.com>
     41     Chengwen Feng <fengchengwen@huawei.com>
     24     Stephen Hemminger <stephen@networkplumber.org>


The next release will be 26.11 in November.
New features may be submitted during August:
	http://core.dpdk.org/roadmap#dates

Enjoy the summer!

Thanks everyone


