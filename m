Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E34CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:15:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 234F0402BE;
	Tue,  9 Jun 2026 11:15:12 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 1996E4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:15:10 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 97313EC0225;
 Tue,  9 Jun 2026 05:15:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 05:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780996509;
 x=1781082909; bh=6NDH/UIeNj2fzgZBkiyBjjs/fI60wSaH0FQr9gbUyLc=; b=
 P6c+DOPGVnGrCGkYiBb3sbDVMq3YwrfK++QhEvOufV5PY9siPn7InHhTe/WGjs5v
 9k3UXKi0JQ1x+d5nWefo5U1upr01HjTDVUEFGEGJ38C1GQkgosAHAEOF3Wp5EgSJ
 wX+DmrHCy67HznTde0xsmkmm9J9fKQoiXl4xgLO29NRaGsOMV/L3CgeMt8fiDMCy
 ibmiVNlZCfly4acoCWoyK3qsEWNtJol6Mg+SG+seC6vYTA+GhVeZh5sOMI18DxP+
 M6nd3c0vh+B31lLKaGgwKIF7wwQIu0tejkXrEjcoaK9oJ5XsIvlehLb2/eYZBBs8
 7CRpu2AtYzWAPQ5a31DI0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780996509; x=
 1781082909; bh=6NDH/UIeNj2fzgZBkiyBjjs/fI60wSaH0FQr9gbUyLc=; b=h
 usfxaWEv9Ih/dNE4fIYdy92AptgLWqX/aaqjSY+BjTsm9jXsLoFNSx+WzFyVRrNC
 z5Jg8SjdWwHn3IAHwEiuyBgsvym3/MNIZ9iMk0XVvpWDiMG/xgkoTDjn9gqc/pPG
 zE2cC7DWUcQEnjg1YuxUeMCeqksa/NrgkV1eVj8+4qnLrW9TUJqoOOA0PQi0NdHa
 JLRjVbPWH0ai6OK0nhZcUP+6aXNXgNkkVmSPmkDC6Wo8taBqd9M+m202pDqHFEMA
 FPakBT2TdpWGk7GcFUoE8bJuaA8SMb/Ci8qxV27sZ8/fiUiMg7Imm26osZUPi9fO
 j9CI50SKe8/NKBhXAzDEQ==
X-ME-Sender: <xms:ndknam6A-xmpNA0EtoOdgttRcQyO-7xAmvHhMTJMn7KZ-nkZwdinng>
 <xme:ndknao3c3NIeKSKYf_yMmrARxYyWQgb4Zr3bHjKRB6Hm0edxV26ozoCdAh92MmVwX
 9K8SoCKQ_4UHQ-VhfXg-uzKSqD7t1MHHovSrNvWVs4iskxKzMZ1Zg>
X-ME-Received: <xmr:ndknahDeZSSqOpqJ_VtPjJflBa-gOdRMZk7yfCmc7WrJYd6vt5lZmBPbLNCnBNFOV6Sla5g3rYwt-3H1W_6ba9-RjQ>
X-ME-Proxy-Cause: dmFkZTFVBkvMn0ur+1KgVktFwnn8GKs7LmyWzNLYwZXg/zEZRzN48MXrHaJjqxwVEaS2m4
 M0gKq4HI3ya2wPnUPXgEVYn+HygWUIygWh1FgXMCEyI4RV+qqFAymyMT7vF2+rFisxyfZh
 OTHVXcdl0g9ucuhwUd2js4IDSBUdX2lwUUIXnC0VQAHgeCadzXhG8O9awK4wpQ2sX1jALO
 7odwO6+yzBFfBhOfxFarP2om5M1M7mVpHBd6EWxeo45JzZAk50Alf2uSE4zvBPT4XcPSdM
 bC3EC2JS9uT9tOEv2QMPKFrLD5vu2x0PJuHLLhPT1wg4QlpkgLNOlHO/LkNDuqDQYXgEfu
 fucpU0n2S3Qw9VkV29bQjD6LbM9oealgErhSMPKGr2gsbTWsLyyb/FsgCblBT8xmQVSCdQ
 bQHZbaORljUjEUQu0bAeqnwdaFwmFvzcy9LOCobhPhEjHT9FRC/FrwxHyIA2hX/7jY1Mf5
 MpSFarFtWt8oVgJb2GDeUfqtc5ktJJMc6WHWZ5FpMuc2Gg16l1CDn4/v49dOFuRQhjGc88
 NnAMW3wHsTTNHYCq7MTy+p7lQFxsUWrKynBIM2rCypgGSCoSbsZgCP1BPacak1ZhAym1kX
 4l4JwuGk54Vp7XpmDXAp7RmN0I4hjjXr9fdxYeoHMiGV+o0UdAdEHqMosmsw
X-ME-Proxy: <xmx:ndknajMuE5Mw9hDuhaaCmK1hTiAP_vglahp6RRcrnIa9UP_0bl1Haw>
 <xmx:ndknambYc_SPgingjWtvi7MfSgVYGY8eHCycesDYovZBqxXuLqc_GQ>
 <xmx:ndknais3tP-fsZ8o4ZVhzCUJUPhZ3x9dR-UDpabxxk-bItq2hlsPuw>
 <xmx:ndknaoPuZVVFLSEvHpFurJkdYtIC2g9y8AP6QLCrnyRK7Az6wJixpQ>
 <xmx:ndknak5-LMf9isKeTVgrP8b-dWoa_GmXb81jZLIUm14q7Vxsexb2wpFZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 05:15:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com
Subject: Re: [PATCH v8 2/4] examples/ptp_tap_relay_sw: add PTP software
 transparent clock relay
Date: Tue, 09 Jun 2026 11:15:06 +0200
Message-ID: <p_KNjZUnRFuVgaqDyhfeWw@monjalon.net>
In-Reply-To: <FtOw8lUNTi2iReVfgCFy-Q@monjalon.net>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260509232551.2844201-3-rajesh3.kumar@intel.com>
 <FtOw8lUNTi2iReVfgCFy-Q@monjalon.net>
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

09/06/2026 10:52, Thomas Monjalon:
> 10/05/2026 01:25, Rajesh Kumar:
> > Add a new example application demonstrating a software PTP Transparent
> > Clock relay between a DPDK-bound physical NIC and a Linux kernel TAP
> > virtual interface.
> [...]
> >  doc/guides/sample_app_ug/index.rst            |   1 +
> >  doc/guides/sample_app_ug/ptp_tap_relay_sw.rst | 212 +++++++++
> >  examples/ptp_tap_relay_sw/Makefile            |  41 ++
> >  examples/ptp_tap_relay_sw/meson.build         |  13 +
> >  examples/ptp_tap_relay_sw/ptp_parse.h         | 211 +++++++++
> >  examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  | 432 ++++++++++++++++++
> >  6 files changed, 910 insertions(+)
> 
> You didn't update the file MAINTAINERS.
> I assume you will be the maintainer for this new example?
> I will update when merging.

Sorry I see you did the update in the lib patch.


