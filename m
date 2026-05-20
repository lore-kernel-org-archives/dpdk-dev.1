Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72510CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:06:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B95E40608;
	Wed, 20 May 2026 17:06:54 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 0943A4042F
 for <dev@dpdk.org>; Wed, 20 May 2026 17:06:53 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso4995851eec.0
 for <dev@dpdk.org>; Wed, 20 May 2026 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779289612;
 x=1779894412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOrJQhDODVobDfwkKopu5EeylD2rC4/7QxCkkx8kCBk=;
 b=JT1qNrp39jHvHKRku3aO+Jc+erVcIn/3d3S0px+PvnF6WHMT45SX19n1gnXK9QYwk3
 bf59Y5+ahlkPEoG3Q4ScNFKhM8diMJhGSEcOyQkU50F4ZJg2nUgMsgyUdJeiNLVNKzBv
 lQry6PLX5u0K33Hj9xXaxXE6cnJn2e15j0CNCzG/r0gO9sYSGbkVVV59vMZVB3NFVye+
 VnqBv7oZFB9/WHePxYHHnOtxUpO4EXQcUQKRfToYrUuuRfssZrvN/pnJUT93Lco9ejpJ
 K/UdyueUbzc9bydiNCDsAhYC5OVrPuUoMkFiGpo0N7Ujs5iYaQb+sf5mmZEYqEFufH7Y
 h77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779289612; x=1779894412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOrJQhDODVobDfwkKopu5EeylD2rC4/7QxCkkx8kCBk=;
 b=FJSGIru0F6VEnQcieZLABlyGh/23jpmtyLkqAzyGx48loXkzkCETXATNKqLbl0DhLV
 cDSr3xEG6bPMo3YdB/0UfkcRjuPnAfzHCdog+BhaD7Q06MtCMKjczejV6tlPE9EKaa+x
 05qGyfstAMHpqhQcYLHq9q571d2mUG6smy9Jlw7UPpPdTiAXJgrqFB15ojLN3q1s0A1f
 Q2GAWm4epTl/ZGg3jFbbrzhyVRLA3saJSpLb5fGQ73wNGBW9O4pAlY5rkOTvAepadmkX
 7y5r2Hk/mz94nGwB1U+VAZA6koNQz67npPVeZXRYJLyG++OJFMWEbCvqhfRf5Fww4W+l
 7tMQ==
X-Gm-Message-State: AOJu0YyS3Ye69eXJga66gkdr11QdKTA6W73z8m68xzCSvY7VJwGgpPB0
 +3fUZEjSdBdyDjbBYvPISrUS48vieQ/1n7oxZZguLaqgztRd8tHgOJaXWBUfZeNBfro=
X-Gm-Gg: Acq92OFdomrflSGiF+wh6TyiH1/CyQz1jr00r4PqqyybEQ1g/zPKM/uBE4pvbB/kby/
 1TFu06CZ5/DwZjovT1RzJOTAxxe0O/3TDFy60sTfi1RigobAhXNF2lnhlPxR9df2erlcgN7ElxM
 o3rwSsiqFw0k/bBf2g2H2guU+rdkyvMi+NbXvvb2qXfmhYGjgV3SJrZayBKRq3yUisplf7MhRG5
 JB95hq2daNFrUeqrNjNJOlxGD/JHEK29ePN0fFnABXXa9wrdvW5qoZpvge1wlfy4052hIdZpldB
 gyU6CZaR4DR+PtdfGKHMdHDrefigSViRVkZwc6BL4BYvSOpPHYR9vh17H+pCCtqNfEMDgV2NTOF
 dIq/Qm+782A0kOcdZ+9y9Ikw8k4KgryZg0+zpolZabYToswu3Lx2PoTDOqg7uZpFa8vHYrqv7Xn
 xgxcog3eW0HhVfoC7fhYm1Ny0YaM/gTH7iSy8iBJjBGdouLj1xrRUMdMhVV1gblz88vgIZG9lWp
 2E=
X-Received: by 2002:a05:7300:dc97:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-3039818a859mr12687175eec.5.1779289611907; 
 Wed, 20 May 2026 08:06:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30294adddaasm18901072eec.13.2026.05.20.08.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:06:51 -0700 (PDT)
Date: Wed, 20 May 2026 08:06:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [V1 1/1] net/hinic3: Add VXLAN TSO function
Message-ID: <20260520080649.67af0f2c@phoenix.local>
In-Reply-To: <20260520065817.931-2-wff_light@vip.163.com>
References: <20260520065817.931-1-wff_light@vip.163.com>
 <20260520065817.931-2-wff_light@vip.163.com>
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

On Wed, 20 May 2026 14:58:15 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> The RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO flag is added to support the VXLAN TSO function
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
> ---

You need to do more than just advertise the capability to get the driver
to actually work right.

AI explanation:

Error: VXLAN TSO is advertised unconditionally but the underlying hardware
feature is not. The patch adds RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO to the
unconditional tx_offload_capa assignment in hinic3_dev_infos_get(), but
the Tx path in drivers/net/hinic3/hinic3_tx.c:306-313 rejects every VXLAN
tunnel mbuf when the hardware does not have NIC_F_VXLAN_OFFLOAD:
