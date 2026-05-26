Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97074CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 13:23:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8818E402AC;
	Tue, 26 May 2026 15:23:17 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 6562540290
 for <dev@dpdk.org>; Tue, 26 May 2026 15:23:16 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so9544057c88.1
 for <dev@dpdk.org>; Tue, 26 May 2026 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779801795;
 x=1780406595; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6ktdUjkMUUxQDffPMysV17TS3rLgVhomYEYm2lG1Rs=;
 b=NNn8Ng7vWzcGKQMjBxQ1lSTYOkXyzFc/mMT/aC4NH0UeaoYzO/Jb9MO/BfkWPDwqxx
 4EXTY9SHmR86vblmDUg2rkOzW1LNwhj4FkyU1PVx42zojWbpAQQq4mB75efH6p1AFsQs
 nWxYc8PEb6k/uNaucXlxx34IAUa94jGVH4Dr2ZBVV335N97WEu0Xp9xQ3XgmKQ8wzFMk
 bdz0HoxHY/Lo7s8FqPZUD28bFLyIdNjttp6/geEsjX+vne+Q8Jy6Zk3hsbfosu2MAlJL
 Cu3oA5jozu8z6SjItog2uaaQRt+Knhsfm2wAhyO10mfX8tvonhPo1LUdqw7SrF6Pe+Vq
 5QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801795; x=1780406595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6ktdUjkMUUxQDffPMysV17TS3rLgVhomYEYm2lG1Rs=;
 b=elDYFMIyVXtIV6prof/8ZX1TaXapPzmRSKCjRFw+NpfMotNs9c7eIg20JFvAX/O0mf
 k39X9zdLQtez1Yp3jrmsK7V2uIogE12vroXC4O9/B70EPzQ2ZZvq49BGiJekxFQ8uTfV
 phhmfYTK0IsuoEZZtDmEW/hj0xac/df25ny00IqZfIK/1QFWShhDjdy+Xrb+kGJ8GjA7
 kyansZwtreMX4ms7yPw1/oYdqDkTFhcd0mSvGY71sjMyIWFfikHUV8Z5m8BVGWXK7CIU
 G0pp1OI50Lb3RvY8bG4240gmJe4cW/pe1FxBvCR8PonELBLZnj9NpKjYyK50im8PULrZ
 Mfbw==
X-Gm-Message-State: AOJu0YxgUww5n1g6jOdedesnMSABcK8lrnf6E5szqnW9DhYlRC05ppDE
 Pa/+oJ+vtXJnWkf8aX7G1+CwPLv6cFnYmbYnhG/JZTAj5a+YkkPhnh75N6UERiru078=
X-Gm-Gg: Acq92OEwZkCDYx2fcTOHwZuaJSCUB3yj1gSiPITUhk5BQvE4gfamDX8A13XZQlGsXp+
 t3oqXn6p3a3YCgjbiFb2KT/T6Juhfb/6vHtqqE37vtGEgcmRwsXULptBqRW+FgLppdavKGhA6wz
 hEoOdJ5VqGHk/rw2rEtOgxJIH9/0Mttq6+GPqbikCnARhKwaUM7yuksnpEof9oFLlyddLd9CS/P
 LJguq+AdZjlFzb+L89LyzrgK5AN539WYOBbU80+dSSOVIpyiJYcNxakXWbQf9MoIB+9gqy4kri8
 KSSTBC4LvaJ2GTFjKDW2PeU4h6r5huk53IoTycXkjTiOyE5OVAaitJqIIzNU5e6FSyQOKqFJU9r
 XpBSTEUtAFwcaFCCPkcG5yHnYH5AlUt7p3RNYggIuHLNEjW8i96vHKFuXa7ItB2OAemy4y83skG
 FuQTriTdh0q90EdgCqPg8+gQOheU5tYQehVUxpE4o1PWAzAHHWG1yE7XsJ4Gxu24SJ
X-Received: by 2002:a05:7022:459e:b0:136:c77a:64d8 with SMTP id
 a92af1059eb24-136c77a698cmr3187149c88.20.1779801795272; 
 Tue, 26 May 2026 06:23:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366aba39d7sm7708633c88.14.2026.05.26.06.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:23:15 -0700 (PDT)
Date: Tue, 26 May 2026 06:23:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>, Yogaraj Baskaravel
 <yogaraj.baskaravel@ericsson.com>
Subject: Re: [RFC v2 2/3] lib: add fastmem library
Message-ID: <20260526062312.33f76fcc@phoenix.local>
In-Reply-To: <20260526085743.64396-3-hofors@lysator.liu.se>
References: <20260525103642.55255-4-hofors@lysator.liu.se>
 <20260526085743.64396-1-hofors@lysator.liu.se>
 <20260526085743.64396-3-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 26 May 2026 10:57:42 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> +__rte_experimental
> +void *
> +rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
> +	__rte_alloc_size(1) __rte_alloc_align(2);

Should also add attribute __rte_malloc which tells compiler
that pointer returned cannot alias other memory

And add __rte_dealloc(rte_fastmem_free, 1)
which tells compiler that the returned pointer should only go
back to fastmem (not free, rte_free, etc).
