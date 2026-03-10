Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D48FFCC9A8
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 01:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA294402C9;
	Tue, 10 Mar 2026 02:55:14 +0100 (CET)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48]) by mails.dpdk.org (Postfix) with ESMTP id AC6A740285
 for <dev@dpdk.org>; Tue, 10 Mar 2026 02:55:13 +0100 (CET)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-4152698e745so2787127fac.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 18:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773107713;
 x=1773712513; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNQZ4UNirz+vgQGLGWxqelCtZesTLwnRRHFl9uSP/8s=;
 b=l4J0pkNXzFJxDmQn0vbbJ/zhqic+qbdgPBvq8OCnVBvWic1WJN8iyCtSdSQIqFqk1u
 lrzbcxqDUJaxGfnReKofULdLArrBsEds92O/ViqMV9u9Da2GPasTWrPEutYgcLBG864Y
 Lvo46eXWwwsiX6aHe+K3RpydGjhvUT+izfQ+lo5hcp4F6AxDevV403YoNhObipXOFAC2
 EqxL47cIn6V0RyU1s//cEwNTar7nP2pVwRpTeXRCY7qpQWdHOtMIxfNZCHrTksrC9/GS
 HSFWiaff/3uR8ItvEov5uQFCiD4Z6xnTN17dhLk9O4kQr+TNGDOw8/tLTDbO0STl7p96
 GwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773107713; x=1773712513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TNQZ4UNirz+vgQGLGWxqelCtZesTLwnRRHFl9uSP/8s=;
 b=J5VgFc6aAdXDRsR1lUAKtN1Ki6fNbtsUDdfuyd08VZwM8K0meR/J/K0UsTg3hsJT5k
 AUmA/ptFuwfCUNMtFxZ2hjcMLUKyMF6VMKZFeG2LE9m6m6lWcsHZHqgKHhXHwXKkIcbW
 NygQGRJHVMQCIzGPcrRuGLTAqLWuMOsGP+iVO5H/cr01AwdJpf64SjC8paa/kDMaVADV
 wWLr5gZYNxIpzUgKIT8m6IM4C5rZfaJ9DGGrKtWIYh1R7QkicfzUbGamZ903FPGs5dyk
 YreLxp0KzoR8ajRcVFIL9yZzYVqhZ2gOMayq6PKOGNAPcOY3x/7rDsv+ETnTrHJBY2IE
 cXMg==
X-Gm-Message-State: AOJu0YyXZrxn0at0D33M3evZvSuq8gA/2AzMym0sVPiSQ6NzS7KVzw4S
 2qJuSnTjeHdLPwaHl3xj9MPUEI3NpBYl/C3C8htAZ+ES1+H+vhBaY8Jwe7DwyCief6E=
X-Gm-Gg: ATEYQzws4cTwikJCYaN2pcGrO9XhSv0Iy3Gb25U7JaY0wpIGg+5o+hjNDemVtMpbcxE
 DG3Fl5C6njQuhH9lTinxLd3ue6CBYBe1bfNnOrM893jgvH1XiRtsp1pOjTEX0xlagzII01e6YJc
 +Y0qEhU/34pa6XCuFvu3Vko1U7l8qMu9OchlNHTvViU3gUGDilSFN2rUiqu5cdALZAR4vupdshg
 zio2FP7T/zkV0FethOBSIktz/tslp6gZff2ZqVSGksu1DWxFbu8ZB/kmk6ykMoSARgyPWkV/bWs
 M42ziwz/BXN3Ejskse6nwZMShyP3xsZGscS0xkc1iUsG5D54RlmP+0/yyIRfQcs9SN8XwJmK9Wv
 wM6nSeerDyYL4X7Jei81J7sJxIRT+2gY2E/wWyVvNORQADV1pC6A/bQNuWMCfaS+/bTwnidqFhk
 ffM/vrIHVffpQF9nlSi63diDAh3S8rAVNRczI=
X-Received: by 2002:a05:6871:68f:b0:417:58c1:6878 with SMTP id
 586e51a60fabf-41758c1ba47mr908208fac.0.1773107712596; 
 Mon, 09 Mar 2026 18:55:12 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756dbc7afsm1206080fac.14.2026.03.09.18.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 18:55:12 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:55:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 0/3] net/af_packet: fix MTU handling and add jumbo
 frame support
Message-ID: <20260309185509.194f38a6@phoenix.local>
In-Reply-To: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
References: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
 <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
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

On Mon, 9 Mar 2026 17:10:18 +0100
Xavier Guillaume <xavier.guillaume@ovhcloud.com> wrote:

> This series fixes two bugs in the af_packet PMD related to frame
> size calculations and buffer safety, then enables jumbo frame
> support by deriving the advertised capabilities from the actual
> TPACKET ring configuration.
> 
> Patch 1 fixes the data size calculation in eth_dev_mtu_set() which
> is too restrictive due to TPACKET2_HDRLEN including sizeof(struct
> sockaddr_ll) even though the sockaddr_ll does not consume frame
> data space. The formula is now consistent with the RX and TX paths.
> 
> Patch 2 adds a bounds check in the RX path to prevent a heap buffer
> overflow when the kernel delivers a packet larger than the mbuf data
> room (e.g. if the kernel interface MTU is raised externally).
> 
> Patch 3 replaces the static max_rx_pktlen (RTE_ETHER_MAX_LEN) and
> adds max_mtu, both derived from the configured TPACKET frame size.
> This enables jumbo frame support when the user specifies a larger
> framesz devarg at vdev creation time.
> 
> v2:
>   - patch 2/3: fix Fixes tag to use 12-char SHA (checkpatch warning)
> 
> Xavier Guillaume (3):
>   net/af_packet: fix MTU set data size calculation
>   net/af_packet: fix receive buffer overflow
>   net/af_packet: support jumbo frames
> 
>  drivers/net/af_packet/rte_eth_af_packet.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 

Looks good to me, so sent AI off to look at the fine details around MTU.
The one observation from me is that the new check for data_size is redundnt
and should be removed or turned into RTE_ASSERT()

**Patch 1/3 - fix MTU set data size calculation**

The sockaddr_ll fix is correct. The formula now matches the Rx and Tx
queue setup paths. Good commit message explaining the TPACKET2_HDRLEN
decomposition.

Minor: now that patch 3 reports max_mtu correctly, the ethdev layer
validates mtu <= max_mtu before calling the PMD callback
(eth_dev_validate_mtu in rte_ethdev.c). The data_size check here
becomes redundant dead code. Consider removing it to keep the driver
simple and avoid confusing future readers.

**Patch 2/3 - fix receive buffer overflow**

Good catch. Real buffer overflow when kernel MTU is raised externally
past the TPACKET ring capacity. The tailroom check, frame return to
kernel, and dropped counter are all correct.

**Patch 3/3 - support jumbo frames**

The max_rx_pktlen and max_mtu derivation from the actual TPACKET ring
frame size is correct and consistent with the data_size formula in
patches 1 and 2.
