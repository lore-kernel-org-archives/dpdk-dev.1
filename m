Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F8F9936C
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 10:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B13D840270;
	Thu, 23 Apr 2026 12:59:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BB5EB4003C
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776941982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H8xQpH+O/RMwhngQqnuDcCtZtfvWNnVXKYYoOQaMGmU=;
 b=hGoWVlewxPv1gB//HJ3yKXvVPfRlKmp7W5Wvs/Vt5tNy81veEfF5lh1qRGFq+UEuwkpQpa
 6sXoxD2DBSxKkSoFppU7MdnnsAtCUkTMAd5qFNpTpUcbaA9DKIctgaqaT6wv2POk+lKVo3
 Bny5RCJWrTNBrtloOsrWjf0jtlT2gug=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-ys0654IlNvqnq4x9lR7vRQ-1; Thu, 23 Apr 2026 06:59:40 -0400
X-MC-Unique: ys0654IlNvqnq4x9lR7vRQ-1
X-Mimecast-MFC-AGG-ID: ys0654IlNvqnq4x9lR7vRQ_1776941979
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so3708840a12.3
 for <dev@dpdk.org>; Thu, 23 Apr 2026 03:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776941979; x=1777546779;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8xQpH+O/RMwhngQqnuDcCtZtfvWNnVXKYYoOQaMGmU=;
 b=ezq/ZhkqCeQyuv9D68fP/RCf0P3u0PR4efK7xOuoFUgKJ29aZjtljNFGAZJHmn7p0a
 wOfV9o2uGYllwQQTAwRb/acapgiMoeAyCiS8vFCay5UeEB0vptZrZ0NdW0e94clKGijx
 7AI07F0X5ekHiaaTz9YjHaQivHZnOuUI9ZhAIEZSI916EMP/kvq/Mx7i1G0WZxDiT5kb
 /A8zBLaT1ks2/VZZbzoWZ4T0yqpmPMn2LiQ7sq713htQgjnqytSCShZ0PZHbI3KCJZy5
 /C+BRRVcDgA3b8NBWQFVR/BOedBuSF5cVQydTG2WZlsFgVW9/wPwpV6hkMhqIBcLa8Sz
 Nsfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JE/TlEC/Pp9IuHAbvV6YycAR0qhM6AQu7WfR7+345Hwj3A3WhCaDr3h/TdPSKpIM4W1U=@dpdk.org
X-Gm-Message-State: AOJu0YxrnKaZdXsNIM/nGkZaxYdHzVxqY2OYlKdYxrFYEWq3AOLABW60
 joHjQ1vt9hCJp1oZJeM/EqIE21yZrvjbRkauo2fwTg/lwzmAXCq2DrHHNNatseTY33VBvtIdKYR
 o0cMnv/NDwZusV6pTOmFMl3AGf+StVOhd8kKIURgdNA65
X-Gm-Gg: AeBDieupd7KPKFY2LZHLn8oDrN04lbTv85FNdAlDrdlvz8n6Z7nbIKisyyWvoQzvQRW
 AqQADDTIFKNsYHfA8VPhLDVDj5P6RNp51/0ufDeIpTBw+Dzh2Q0lV6fIAvwikMBf+GUNUQwqhIC
 D7LaS0ecEwJTHBeGexSKjIHCkFp4XLLBSYWLPjiSW+wGaipcXH2KNaqkBzeWAAF68t8RB9rYqne
 /U2250TGyxhzFd9Luq1gxdE+ywRq6LueQrykoYbSMTmW4y0bPbXkaU+AViw2cKIMeD4Cc8Jr/4M
 T6r37XX5JbmhZPW/q6jhPbUYLE4HscMxxBbOPLa9ZByImqOrz9l8IUItS0AnfYHsLLUChk74AOL
 mxffESXsIkBKGRcsGz12p2E2FcN0mljuY/A==
X-Received: by 2002:a05:6a20:3949:b0:3a1:5cce:caaa with SMTP id
 adf61e73a8af0-3a15ccecd81mr21443073637.49.1776941979336; 
 Thu, 23 Apr 2026 03:59:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:3949:b0:3a1:5cce:caaa with SMTP id
 adf61e73a8af0-3a15ccecd81mr21443041637.49.1776941978840; 
 Thu, 23 Apr 2026 03:59:38 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.130.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9d6adbsm25539500b3a.18.2026.04.23.03.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 03:59:37 -0700 (PDT)
Message-ID: <8561da5f-4ca7-4404-91d4-0c5ea296bb6e@redhat.com>
Date: Thu, 23 Apr 2026 11:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v3] net: fix VLAN packet type
To: Robin Jarry <rjarry@redhat.com>, dev@dpdk.org,
 Gregory Etelson <getelson@nvidia.com>
Cc: stable@dpdk.org
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260422133217.675900-3-rjarry@redhat.com>
 <66613eae-13f6-42f9-bada-d1f3b5d9cee0@redhat.com>
 <DI0FVI2TG9UU.JRHQ224VBSMW@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <DI0FVI2TG9UU.JRHQ224VBSMW@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OKsF6BSmy8TZIKV3fonofJEC_tztszI5A4nYMUB9h18_1776941979
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

On 4/23/26 10:49 AM, Robin Jarry wrote:
> Kevin Traynor, Apr 23, 2026 at 11:19:
>> Not shown in diff, but for:
>>
>> 		pkt_type |=
>> 			proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
>> 				 RTE_PTYPE_L2_ETHER_VLAN :
>> 				 RTE_PTYPE_L2_ETHER_QINQ;
>>
>> It seems to be produce the right result, but I'm not sure we should be
>> treating the ptype L2 defines as bitmasks. Maybe I'm wrong and it was
>> planned, but it looks like a coincidence it works now because QINQ (0x7)
>> happens to be a superset of VLAN (0x6) for the OR.
>>
>> Perhaps you could check vlan_depth and assign VLAN or QINQ based on that?
> 
> I hadn't considered this. It would make sense to have something like:
> 
> l3:
> 	switch (vlan_depth) {
> 	case 0:
> 		pkt_type = RTE_PTYPE_L2_ETHER;
> 		break;
> 	case 1:
> 		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> 		break;
> 	default:
> 		pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> 		break;
> 	}
> 
> Mind that this will report RTE_PTYPE_L2_ETHER_QINQ even if we have
> double stacked 802.1Q tags (ether type 0x8100) and no 802.1ad S-tag
> (QinQ 0x88A8). I don't think this is an issue, but I'll let you judge.
> 

I'm not sure about this.

> I can send a v4 with this if that suits you.
> 

Setting pkt_type later has some implications for early returns (now i
notice that's present in v3 too)

Would this work ?

@@ -358,10 +358,12 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
                struct rte_vlan_hdr vh_copy;

+               if (vlan_depth == 0) {
+                       pkt_type =
+                               proto ==
rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
+                                        RTE_PTYPE_L2_ETHER_VLAN :
+                                        RTE_PTYPE_L2_ETHER_QINQ;
+               }
                if (++vlan_depth > RTE_NET_VLAN_MAX_DEPTH)
                        return 0;
-               pkt_type |=
-                       proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
-                                RTE_PTYPE_L2_ETHER_VLAN :
-                                RTE_PTYPE_L2_ETHER_QINQ;
                vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
                if (unlikely(vh == NULL))





