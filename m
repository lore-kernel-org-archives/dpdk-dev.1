Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A6AC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:40:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EB2D42D9F;
	Mon, 21 Sep 2026 18:40:01 +0200 (CEST)
Received: from mail-pj2-f28.google.com (mail-pj2-f28.google.com
 [74.125.227.156])
 by mails.dpdk.org (Postfix) with ESMTP id 4914E42D9F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:40:00 +0200 (CEST)
Received: by mail-pj2-f28.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso18604305ad.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790008799;
 x=1790613599; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/QpBvtSHLDUltuIF+kGVaUC20haVTVR/MqbmyeeLB+4=;
 b=M++WHmC+t7BxrK1v52CV8wsdu+TPU/aBhnhw9v6PIXiXGwkRBUXAr/eeQMaK0zaxRg
 zV4TFgm1LZNMQmKBLHPyAtWkHHNsghIzjgMzYy0II89YRdSYKjSb2kWCw1kHEcreP8rQ
 60/ChuYtDbhB5mbsaPkwYIDJjkVGzAYmozX9ObI3p9iImTI3U3TE+vqt6MQB+PjCX/y4
 21gsWvEkChnOTNOFDAFoqFCuy1Pk2GXai6O0d/8b/sHpE/pdVjJvVJBknjTe4v0D4N7t
 mLydJjmMnLJtPoQE2839qiS4oTrKGFsHFYM2f0Mjf2Fmw2IiEuRBRwa2kxc90KQJjv4p
 AtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790008799; x=1790613599;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/QpBvtSHLDUltuIF+kGVaUC20haVTVR/MqbmyeeLB+4=;
 b=hJFCBfDztONxIPN8151lNNQV8WRFGayaK8xeUVx+88Xn8PrETNc4/gsnQOOs7//bq6
 9hZe+M6Bvk3uOFJHv6JozGV7B5wV3xNrNwcifejNjaP9kQEEk9XHQnXmt8BnaO+qTVZJ
 hP3G/HT5toYG4wqIaOqmBRcbUFQXHJOqddMsMCCEm/mroYh8Ts5CBQKZSXfWh/UcP/4A
 ERfw2ENipAQ/2GPTEFPnyS2Ds7a07CgIRDNO20YNmc4w1/w9OiHn/oV7u6c2s+KVcf8s
 Z95tW0NGviyyQzwdJc8PzuXbmBMhHJanbidGn+XYBCjjA0LLRmYHJIF1reUkZh27f0sf
 zpIQ==
X-Gm-Message-State: AFuF++kkdYq5pFCF3U5NxGYdJiFfZNT9SvXk4NO+a8/qtwhsPGSjk3H2
 /YqardiOPQ+yH57y/3csJBBB20257VK7dVWBeiihE2WHkqs5zfKEld1Y0QsROhmaEN4=
X-Gm-Gg: AYBFou0KkR5DJqMT38dfMlqXNstcaScoarnggrieqxog37DqSXOrfN+j2ayFrpKSLKt
 d3LtvD7zPhEhxPhc8PIim5uCruRUjQQpRhEuxscDgm7t7doPQh/sTTaKN5gL1z1G1OlPS1d826y
 xHDUV8Twc6Ee9L/1hLvD6pZtDOHYt4Om3C4ZJrGdmOKbjZ3UbhD8docwGh+nZmHgZMAp2WojHCr
 X5ia+1EtbQTINFkxoxd1m9HvAq1TxWww/ItIy7+q/NTC1XCFSCQtZREdRkCpN/a13heYWkojORM
 UUZuuHKBuxWwMox8mZbyYIZGl9V6j4ZKbr3JzxvDPthUySakgmS2gSQPtTEnd7Am7CZRz1idfrp
 XqDdCqdQF0dVWgne6CEEmUw1v03s3/Fx0nQ/s4WReQUS1+99yjSqZiB79mBTKb4qqE1ZteTVWFj
 kaDaasb2o3fCzNWf6AV+uxiRjF4H6bN6I43DpTxPwuZao49I8uvdqSvNC7mDp1ttQYdoNS/t0If
 fWiqya4QcvoAEe3FLN3gDKRMchQFiByxq5Jb2S4fA==
X-Received: by 2002:a17:90a:da83:b0:39e:6c6a:4b68 with SMTP id
 98e67ed59e1d1-39e6c6a546fmr9958611a91.50.1790008799367; 
 Mon, 21 Sep 2026 09:39:59 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0670b410fsm134148a91.9.2026.09.21.09.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:39:58 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:38:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v3 5/9] test/devargs: rely on net null driver
Message-ID: <20260921093854.7846ea0e@phoenix.local>
In-Reply-To: <20260921114737.2334589-6-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260921114737.2334589-1-david.marchand@redhat.com>
 <20260921114737.2334589-6-david.marchand@redhat.com>
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

On Mon, 21 Sep 2026 13:47:32 +0200
David Marchand <david.marchand@redhat.com> wrote:

> The net/null driver is enabled in all our tests builds in the CI.
> Standardize on using net/null instead of net/ring.
> 
> This also removes use of an internal API.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Patch 5/9 (test/devargs: rely on net null driver)
Info:
- The removed legacy_ring_list case covered vdev devargs with 3
  key=value pairs (iface=test,path=...,queues=1). Its replacement
  ("net_null0") has 0 kv pairs, so multi-key vdev devargs parsing
  loses its only test coverage with no equivalent added back.
