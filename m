Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE7D0E6F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 14:30:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C611140A7D;
	Tue, 25 Nov 2025 15:30:57 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 84D23402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 15:30:56 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-bb2447d11ceso3360126a12.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764081055;
 x=1764685855; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9U/bFr5acrKfrup9ou+WElZdvQovVFgpu7LDnpF7fZ8=;
 b=IRLnMqhiFqKGICLcW2q1Xg9SS4RNqWd1s3aO7EAwT5UWlTh3tJcQDQG7nONb80nvg4
 iDq4mOCW7fMf2SFAS8WSMKVSr7qxMzPbtj69j2sNr2b8LmeEBVO6gNRTr4Vj54QxisJR
 hiQ78KxtyTAM1jKRjH0evir6hkqt9e9e2KZE1qHO+JS/dEisQK3Z+8DaIglOrtCmYv86
 UqdvApeL78Z2Vkq9mO5SyJ+gYfNcPSgqmCDwRk7JCuEBcjDZiGSKiHV8t0kZa3OnkWEE
 hdElC/YcjsT18lEaCEB9dYc61LT9nmaN+ePxg5o1C+jbPsVPjhFHpXKmAGXsOkVmCK10
 PTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764081055; x=1764685855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9U/bFr5acrKfrup9ou+WElZdvQovVFgpu7LDnpF7fZ8=;
 b=OzRrHaYdulx/OLVCqiY34BoVLoSO7fWoPpgFi+H/d7jJCe9gZ4+plyWtPsUDtx01yM
 UW2iP+pBc/3hLiFWtACbevcyTMrxSLqFzdx5j/PMPU+9w8PjcPLsZziVNvRfbtYn3IBn
 Hcu1zXpHShEv/WQD9d8DZ5ujHbzMivlnwNF0eq9PJSKGVPjluYFxXwhyzrMvrg8ls9JE
 g9cJarji/n+j4tEXRZwFASc2vHeLsHSqUgxuEsvk6vCAwq+xFKr4P6KkbyeqFBZsN+Be
 63VmpeB9/xuI4rOph4si4XvYvMYO52gMyClrt1kkiRDW94GrWzZCLekVOmxi2kw+0F0W
 GsSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2v47JqJIDwaghqAwfDjmGvKzcLOVTuO4zs4mRZSZn294U1+mKhP/6qMQ9fp/JYiCm7d0=@dpdk.org
X-Gm-Message-State: AOJu0Yxejteg2hpdniyXPP0OQbrQMjetjy6nEKcXHAM3bHhiKZ6f/EJ9
 ZAWGsOdCTJN0K0Opq1qG6ipiESWzPtsF2n+Hk4ShW+IaKz8KZi+WgpoAi3ueLFMOJ54=
X-Gm-Gg: ASbGnctYyGttuyrOD3cavL/lXak1H/nEAiDOo+sLHKWj9OG0kLgDHoqyjX4WDDNfP7r
 1MSkudE7QnfRXap/Y54bleKd5zc11MvVJFCNtT5li4Ub0Cyb75cuBawEfDEkKIMtZuyWqA/e86y
 kTDkY76btEZVC2wOUTbtwL2HXU8UWn3vXNBv0zEvZK4zX+ssPHsAVxmm8mn7vXfnpD0yIyjke3A
 v7uMAJpGKG1/D6ML3kTkebg9U8Ss01lBPVFobuVDL7t1bdvRjeMmKFPGvJFLyefLXmu3i7G2HTG
 r3txNU21HR+s1MVmkMSnj37ddzhnHGUJDVZ7CniQYp9AAZb7SOO4/3ho5lAfBK/DN5V7tP5lTEf
 MgF0Nzv76RpiRT+KhNbU879JWR0nffccU/N0xtcSABlKkJkJtfdr65vyUvlE/pLwzUj14gpHCkv
 5Bwj2tC+vhDpUhpGS55YBHKfgO0Z+j1PuqQbJ2xw==
X-Google-Smtp-Source: AGHT+IHWtJcr/cFWJCx4bPsWIlPc55WZ9aH0rsfe6tHtz+NCvxibNUy21ba2Cd9JFXiizzDCc+sX7Q==
X-Received: by 2002:a05:7300:f0c9:b0:2a4:5ce8:44d0 with SMTP id
 5a478bee46e88-2a9418bbca3mr1181916eec.38.1764081055076; 
 Tue, 25 Nov 2025 06:30:55 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc204881sm69506325eec.0.2025.11.25.06.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:30:54 -0800 (PST)
Date: Tue, 25 Nov 2025 06:30:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: a.schollmeyer@syseleven.de
Cc: Aman Singh <aman.deep.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] app/testpmd: warn on shared rxq switch mismatch
Message-ID: <20251125063051.0563732d@phoenix.local>
In-Reply-To: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
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

On Tue, 25 Nov 2025 11:22:07 +0100
a.schollmeyer@syseleven.de wrote:

> +				if (o_dom_id != dom_id) {
> +					fprintf(stderr, "Bad shared rxq config: "
> +						"switch domain mismatch in share group/qid %u/%u: "
> +						"%u (port %u) vs. %u (port %u)\n",
> +						(unsigned int)rxq->conf.share_group,
> +						(unsigned int)rxq->conf.share_qid,
> +						(unsigned int)dom_id,
> +						(unsigned int)port_id,
> +						(unsigned int)o_dom_id,
> +						(unsigned int)pid);
> +				} else if (o_rx_dom != rx_dom) {
> +					fprintf(stderr, "Bad shared rxq config: "
> +						"switch rx domain mismatch in share group/qid %u/%u: "
> +						"%u (port %u) vs. %u (port %u)\n",
> +						(unsigned int)rxq->conf.share_group,
> +						(unsigned int)rxq->conf.share_qid,
> +						(unsigned int)rx_dom,
> +						(unsigned int)port_id,
> +						(unsigned int)o_rx_dom,
> +						(unsigned int)pid);
> +				}

Same message repeated twice, change the if logic.
Also, why so many casts? Those should all be unsigned.
