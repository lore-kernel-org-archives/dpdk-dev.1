Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B591CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 10:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAA524064F;
	Wed, 20 May 2026 12:24:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A58F84029D
 for <dev@dpdk.org>; Wed, 20 May 2026 12:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779272674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XorSAeXNUqIFi16miijap6MuEKaa3CqAdxSZ4fvW5Xo=;
 b=XrxrxybCvfEBXPNg+ZALzLPLPmQ0TRW8qLtgnAK+M4so/wrhuNadvNzGMOzwgpW37gjpBB
 w+utgiP95W2XxRYXQOe4qFNDTcjT5wGkuzAaLlWoliEWJMUP6TUyaJSARNfQ42TtloxyCu
 Rc99QaYLgPQNu9pElHPvEbpjVP9kNsI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-3qYLctUVPfaLRTlNudDEIQ-1; Wed, 20 May 2026 06:24:33 -0400
X-MC-Unique: 3qYLctUVPfaLRTlNudDEIQ-1
X-Mimecast-MFC-AGG-ID: 3qYLctUVPfaLRTlNudDEIQ_1779272672
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48ff0eb77b5so45473915e9.0
 for <dev@dpdk.org>; Wed, 20 May 2026 03:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779272672; x=1779877472;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XorSAeXNUqIFi16miijap6MuEKaa3CqAdxSZ4fvW5Xo=;
 b=GuyJGe4MLpRRaT50jTcSG7Q02KBu4oNXHYbLDn4uEC1KMjN0Dxi2FTuEZ3nFZ6nRSc
 M2xqedQGpAiow3DrrFN1j7T2NROo7EsDUGeZC7JoLNeLDfHTj94ADlWkhD3f3SuLPPbu
 eh2npsWWq/lzZkA5JJ1IuoauB0dr3tx5847zFwTmiiH7hTZJk3/meorvNBVuRHG7eutS
 +qxORzgwukYrXFZ33tLSXjYRYJjpOgf9r1j4sgjtsfd5DsBUHCL+YR2n4sAgrNzpSVU5
 qbeX87fdL2c8OgVIBIV6X8bUcXrPeZS+Z4jWfrBVTaEa2jkL9A0AAuvJk6fPbx4YkMJ3
 s8kA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9l15Av03sYUgTe4SLVtBYJQUHkYh0JIUiFqxj873smkSDgSSonwXhjv6cygWjSbPAJrXc=@dpdk.org
X-Gm-Message-State: AOJu0YwVRzlyxhX04thg7RwElRVTHc2q8EpW8MGfkvfmDbqR1Vf4PqBE
 2ttJXVwCI/bf6DXbIunkFrHZSSUzAPz0peMF6r+JZT9mBXQjSznT59vkRjOlLf+TgIFavxUZfEn
 7vfyTGKd16ohA4yaxaPMnKbc5chuxy0dmAdE4dJdf+czE
X-Gm-Gg: Acq92OEUdo5q9GvbEM6pkg088r+xNHQhIUrsP6cyoOIpuagypEbu0vLAIp+n3RuPOOi
 G9ieRWzxGZRdFXpNyZ1nu0x0/fJIFh1tfVe9FWUWLaEUjS5G7/RhJRDlUinEjBvK+O7zdl3PyS+
 ZIQqK8PHhHc/DmFC0DZAKyixzEfyKsL78jtU5biFm0/PSE5TC5zvge+PcuXrxBE9hGgD6mLNYMa
 WlyLZ9lLXM6K4y0vdaUMFcjUFfmauraVXYzUyaYO1zEJDSp79gkUn47KK5P9K4j6lRctZAzrVC9
 SyaHJrGH/nBdQD6Z87u5AeLg62yN853lE0A0KSl72xlQ/qSn65S9dAXXUNC/7aMRcN3iyFfH28I
 PoqlvqDi57CuqsKWy371nuA==
X-Received: by 2002:a05:600c:4e87:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-48fe60e142emr375165435e9.5.1779272672379; 
 Wed, 20 May 2026 03:24:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e87:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-48fe60e142emr375165055e9.5.1779272671878; 
 Wed, 20 May 2026 03:24:31 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab2896bsm131528845e9.4.2026.05.20.03.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:24:31 -0700 (PDT)
Message-ID: <37b0ac6d-090e-4929-bd74-bafbf2e6d351@redhat.com>
Date: Wed, 20 May 2026 11:24:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v5 1/5] Revert "net: fix packet type for stacked VLAN"
To: Robin Jarry <rjarry@redhat.com>, dev@dpdk.org,
 Gregory Etelson <getelson@nvidia.com>
Cc: stable@dpdk.org
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-9-rjarry@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260518132712.70913-9-rjarry@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IylaJPkplkmBp54wrDkZUwn74KaPyVJNpSSx-LtJLeg_1779272672
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 5/18/26 2:27 PM, Robin Jarry wrote:
> This reverts commit 1f250674085aeb4ffd15ac2519a68efc04faf7ac.
> 
> rte_net_get_ptype() now uses |= to set the L2 ptype inside the VLAN
> parsing loop. Since pkt_type is already initialized with
> RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN (0x6)
> results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single VLAN frames
> to be misidentified as QinQ.
> 
> This was detected while testing DPDK 25.11.1 in grout. The net/tap
> driver calls rte_net_get_ptype() in tap_verify_csum() to determine the
> L2 header length. With the wrong ptype, l2_len is set to 22 (ether
> + QinQ = 14 + 8) instead of 18 (ether + VLAN = 14 + 4), shifting the IP
> header pointer by 4 bytes. The checksum is then computed on garbage
> data, causing valid packets to be dropped.
> 
> Bugzilla ID: 1941
> Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
> Cc: stable@dpdk.org
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/net/rte_net.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 

Acked-by: Kevin Traynor <ktraynor@redhat.com>

