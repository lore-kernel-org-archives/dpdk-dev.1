Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABCCD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:24:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1533D4066F;
	Wed,  3 Jun 2026 20:24:12 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 5618940667
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:24:10 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-304ec41197bso6258649eec.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780511049;
 x=1781115849; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U8PIDlf0VlYyPd/YFttcZZai/KLI5fM6n0fDUfOpN4=;
 b=kTHNn3NAyCZYFBlngfVwqsCZeanfPz+k5HW7PfnANi/mR9pB+RnctkEUUjU9rHC/0P
 9IzaG/2wJ9s9i0I8K0QFb0GB+WjsA+8mlfAHNxHJlQQiDdf3ZYp95U0MbSzLzKkTuH6T
 JttfdetyVOfunDiwGJH/7eyywPLPHtCG1ARYy6vcPNMQCRNdmoKCax+aI8OCAqYbcu9Q
 8sBIXXDBao9D6eNn+MKO2Gd2MMufuRIUWyvFNbGKF59eoSe/kJGULsISdpmHw9BBH2G5
 /tzMHU40tEZ0/EpkJCDYzIiw5qmoKXcOsoKnBubmq0+FS5k1rOvK8MuyDZujQrrN2vsp
 fUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511049; x=1781115849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/U8PIDlf0VlYyPd/YFttcZZai/KLI5fM6n0fDUfOpN4=;
 b=U4pxYaX8xASi1XWz9Rgm0y7x+/MUF3FvUtyBRsGB/6zv38pSYNx5y83wvq2dn27Ecd
 AgI29niIA7eFmrbFqSRpb4UaRedE51txg4UcQeGtcQLIVhE2U5GTuiwSeGVgBtmN6tEg
 RUnI35U0yuaj0JiEh5usJ468sEMr9M7aPdvB0LuJjhXIS4A/s2kMWWzBOKIxvtJ+eIo3
 w9I2D3XvTzQakUgn1LGF3Pz75Bh7MWY92rm/rfV79igOkPPg+qdBie5/tpMZvXMFaRP8
 5vuLSxCyO8x+0EsyqBVox7cfCmcqgjtD92VDRKhxh72E03CTRGFHFWm4tG3CEwXmbzpt
 Q9WA==
X-Gm-Message-State: AOJu0YzfnMz1169t4YHsuYFnTguvBjm5mTJrduSYtfdqzIkE7vdzPt6k
 EMMWVgV7I6k1NluZ4nY0PUt6xmPIU0LWROlWhZnvl73Y2bWnJAZmo42zzI6YZKN+Xk0=
X-Gm-Gg: Acq92OE1+0zn2MPgN3w1J6xWrA4uHrvSbmLMayGM29Y3sMg5i2tYprcteeFqv8by8DX
 EYgBhvlAJU80dxNVQ56C+OX6IdolXpfw/NHb+EyR70yn+Xq5xRlyBR7QPQzZf16R5Yqct2T01JF
 jHZmWgGSxjLkwO3n9FljrofMJEGHMhPQqNz4dbGR2E06gNnW5NBHw0vjV9qKx7Tx5rPOfwiATf9
 hebY1e4aa110OOWjK7FegqWIvj/ZCsKFOWHcxFrJgOc6XaoHK9/UzEnQo/i8lzrwlicyPtt06ku
 sJIdZ4y14jbehTaPWbLqPrPu+Tws8qvDM3bZnscKqIXFjXGPGyFOdp2om8INWWCr8qdcUhiNai7
 dnY2K+B6BFiTpiGYlEbTCRxSyM967VBfdKX6eMslXGSfHO8ZdpaL1I6KHu79l1LZ4w/wfm5KE5J
 ItGpV9uQLbRHAG8puAfQ1LNxBicUuNgLcfsYKFfxfgQMWnZ1BXNySnwoz9UW0s7VU94zWlmR2wU
 94=
X-Received: by 2002:a05:7300:371e:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-3074fa3d73cmr2516088eec.2.1780511049290; 
 Wed, 03 Jun 2026 11:24:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm2682632eec.28.2026.06.03.11.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:24:08 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:17:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 07/20] net/sxe2: support IPsec inline protocol offload
Message-ID: <20260603111758.6c1dc572@phoenix.local>
In-Reply-To: <20260603062945.1253672-8-liujie5@linkdatatechnology.com>
References: <20260603022150.1140722-21-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-1-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-8-liujie5@linkdatatechnology.com>
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

On Wed,  3 Jun 2026 14:29:32 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch adds support for IPsec inline protocol offload for both
> inbound and outbound traffic.
> 
> - Implement rte_security_ops: session_create, session_destroy.
> - Add hardware SA table management.
> - Update Rx/Tx data path to handle security offload flags.
> 
> The hardware offloads the ESP encapsulation/decapsulation and
> cryptographic processing.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Git complains about blank line:
Applying: net/sxe2: support IPsec inline protocol offload
/home/shemminger/DPDK/main/.git/worktrees/sxe2/rebase-apply/patch:236: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
