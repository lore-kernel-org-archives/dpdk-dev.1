Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9271CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:13:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B177402D1;
	Thu, 18 Sep 2025 18:13:23 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4D4F640288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:13:21 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4b38d4de61aso16634821cf.0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758212000;
 x=1758816800; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfa1wiCsjCdXAcYmNQzTVn56dtsilTp6Z9h+FzGoimQ=;
 b=DpxMrxdnQgCHF+IP2lPDUXz7OFn308FkbBWkp5zp67JSBUL76ULcuHpxSLcoZVOq+g
 J9zXsJZHrahvCY1UMfcM3Y0sLSZSL+1WUN51jc/sFwXe8aTUeN/0ZNRjNMmDmHfATess
 2H5mF4lQ+1KeX7b2XC+LEk4obAByry4G9QKuul9x8X61Zfgxic/wGEQ70jpoJYhIY8WC
 rfmtM6nqbuQai5/23gv8ohfuedjNbopxdqsWkS1+q6BU62zIM5r1h/59NZyEt6qD4nAA
 5W2fCc216VAcwWlGxI9d3qHT1q7puqo1zlgi65R9/lwVTNH8LK4T2Gkb2zhKm4N6qUrB
 ca8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758212000; x=1758816800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jfa1wiCsjCdXAcYmNQzTVn56dtsilTp6Z9h+FzGoimQ=;
 b=BNbAamk1HGekdTWL7elpPz0KRED7gYsUa3th5kUaUS1IeE3Okc1CL/x5WOtGSdpX7m
 DfPzQQRArxTcUuOCwQEeena3D2m0RGWEGNJ+IwbZO2USXNZJT6q3ZNMS6pAo2GtcWF/z
 x670CGvwuKUMLoNum0072A6pk4xxtfwHL7FHGdo+rCxr4GYOWM+B7Yi9T6EpT41VqRpJ
 jM4QLQPTLAKuLZGecLpXsZXvNiZUN/W2p7Ly4X3KcdEcgrJ35uDypbi4xqrUfAGyXAIR
 jBPVaD7H/jw3dLJz9hFlSrKEzNpexPCwLdTB6UYIrfjCCFsu2IUUYvAb0TYerqkYnrQU
 srvA==
X-Gm-Message-State: AOJu0Yw550mamiObLxmIvayOLUeSbjIp4VEDkPiPGuYLlAXnxmO0p0Jf
 HNGRqtQe8rnvlvS0y6j514YUtuyklx87Na1wWYXHxa4ePMfssckPttekAOEbW3zgZ9I=
X-Gm-Gg: ASbGncuoRfHbZJLzZR/mXPCRkOHHpsUeAH4xmRMO6rf2iq3DlSVlYjfwdq7SkHQbLc0
 9zaAHxOvyxyn2NaSf4/dN6jv0lrsZ3GRgejKynj9uNooiHoCT3XAkMa7oUUUUbCbGsYem8vNj2P
 LfDpewsJWSSEdUDWS+FgzU/oUs6CQ19pBPQmc0g3Abjw8vcar91hgwlcCrGnhkfUhgJaULneP0W
 FT7vrRWkcaFNpAlEOvGc8xintV+CybpYYxqk1LNYU1+NfSKLXhVytQ2D2WiyEfKVijPcVeG47bN
 DYACVKLursBmq9LdFdAC+5XFhiN+XqpsmcgF2NZtps+05BDmG4K3mVM2Er3VLWmNa6C1MtoliwM
 KvfWsfBAd52waSp+Imw9G07Flw9gvXHHepao9y53Nq2spiM1Rk9dgSK9YqdmXUqA/Gc9j4ZPem7
 Bo3asln3xfmatwchAhfw==
X-Google-Smtp-Source: AGHT+IHucvgoCWDFkaePkydlWr6tKa50Ei3/aVxgliOx0wXvevAAWwhs+XvxZC31EVw6S4apWctN5g==
X-Received: by 2002:a05:622a:228c:b0:4b7:9743:6da6 with SMTP id
 d75a77b69052e-4ba6b9401c0mr69950311cf.70.1758212000468; 
 Thu, 18 Sep 2025 09:13:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83633b04dadsm180452485a.64.2025.09.18.09.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:13:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:13:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Xin Wang <wangxin679@h-partners.com>, Yi Chen
 <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [V11 02/18] net/hinic3: add basic header files
Message-ID: <20250918091316.7ae0b47d@hermes.local>
In-Reply-To: <20250917101604.17045-3-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250917101604.17045-1-wff_light@vip.163.com>
 <20250917101604.17045-3-wff_light@vip.163.com>
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

On Wed, 17 Sep 2025 18:15:36 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +
> +#ifdef CLOCK_MONOTONIC_RAW /**< Defined in glibc bits/time.h . */
> +#define CLOCK_TYPE CLOCK_MONOTONIC_RAW
> +#else
> +#define CLOCK_TYPE CLOCK_MONOTONIC
> +#endif

Defined but not used.


> +#define HINIC3_S_TO_MS_UNIT  1000
> +#define HINIC3_S_TO_NS_UNIT  1000000
> +
> +#define cycles		      rte_get_timer_cycles()
> +#define msecs_to_cycles(ms)  ((ms) * rte_get_timer_hz() / HINIC3_S_TO_MS_UNIT)
> +#define time_before(now, end) ((now) < (end))

That version of time_before() is not safe if TSC wraps around.
Other places use:

	#define time_before(now, end) ((int64_t)((now) - (end)) < 0)


