Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C835C369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 16:23:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3798E40156;
	Sat, 26 Apr 2025 18:23:38 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 90B3A400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 18:23:36 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so4232485a91.0
 for <dev@dpdk.org>; Sat, 26 Apr 2025 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745684615;
 x=1746289415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jL37HmFyCd9RzN0cM8w8w0bmxpTU+hRQ84VIQaAM9GQ=;
 b=Et2JmDgYsYfKAi+x0qzbRsm1yUv1cR4E//jok6YJIg65pX0GuW4f8c7qNMPvgE6rqO
 T8H9999KO7x6o526C1tAZdtdzWxnnbErZ45iDhGbsAuKx98cjsjHHtV1YE2PTAXBcC5W
 sMCP/Ep/0IjBFsPg8NQkmBriKMEpcjkoJWhvO5maUMKghuwQstAwB4YyFO1UdvTQoU8L
 0tb+wKdmQ2KDhPLw89sx5GmcA+dUNIAEbxvAPL4l0cTT2+ShaRzdUEgfIYIMBakm8QKe
 HRfkbxwSVfGbMgg9b9WvNSEJL0IHoe5PKMe9YnUskEfjADbDsB+dzQEYpXJwGdSA/cRi
 SAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745684615; x=1746289415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jL37HmFyCd9RzN0cM8w8w0bmxpTU+hRQ84VIQaAM9GQ=;
 b=Gx5zDb6kReRLCcAFrCJc6G8DlF6FNLWaUsXplTkiLXB4E6ogBV8DRttoOk9bZgwEWP
 CPcgO7xz5pgwQN8a0uQ2sKPYTnynd1z3mKB9IzCGjQpqsHQFnh9B4UWNkE64QhgfYOKt
 XNkhJqlhDXjjeGqzOkbSfSA6VL7n9R9GqZobYEnl3Qm2OwxoL615ZqegkkgPeENQq2lZ
 6ABTNAix+mtytme21Bg7trr2hXG4oqtNx8GjGZt86gihGkp4aJa8SXdlhp9iJ131jTyx
 n8dHaU/fQcW+7k2QSnlqRlZqFxT4qvXNyP1ABB5EjRFJxFXzEFgmj0HjFVcBVdwjom30
 Yt0w==
X-Gm-Message-State: AOJu0Yzr5GjUzwdBNojGtSpQX78Qn7jIqzCIUCso903SgQbIgtfu4eI0
 uMHdZ/iVzjEnQ2sOvluVacrjYxoGB4W4gcAGVC8TX7BJsCCiHV4OD1mHCADwLVUXKN0aH9t61Zh
 c
X-Gm-Gg: ASbGncuANRWdXblj9ytH078yIViNweI9xDR3nU+4xAkQvZ3IMgQW789hlWER8XQhVkN
 q0G4sD+SNzsF+wL4+hVSWGHUD14McjLi3rMufjv7CDZQptbfmK+WNp0SaR12LEL9Qo2CZJ3XJYc
 4CNaVNXmDYchOrZAEOA5vtHeJk0fjLY4IFOdRYXfsVzC4AoLrWKdiZvLDqWh54OCMWhI7ERYIfA
 u2TOjoEJbTqtuKNFZiQjG+J/KwyO06Q6EaWJwhZ1E0aVhhOlkm6h4adwDzqdxstfusO6pSHrgCH
 TOtYaKnPsGjydDAKdetBRUB3urco1mFjSlmh2Xry5WmtpAGZtTbV1bM5ZP8CrWnCRMn+AmjaG5+
 lYvouK3Uqaijk6DoS
X-Google-Smtp-Source: AGHT+IHx1eOr9VKhUP9sgEbPQZRtTxfANMqBlDouUy+++kyPI9YtViNNBqw6qVsjs9WkPQPiHo69xg==
X-Received: by 2002:a17:90b:384d:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-309f7ec4441mr8261990a91.32.1745684615636; 
 Sat, 26 Apr 2025 09:23:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f754fed6sm3800148a91.0.2025.04.26.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 09:23:35 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:23:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 01/13] net/sxe: add base driver directory and doc
Message-ID: <20250426092333.36ecee09@hermes.local>
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:40 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> From: JieLiu <liujie5@linkdatatechnology.com>
> 
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

More check issues.




$ ./devtools/check-doc-vs-code.sh 
rte_flow doc out of sync for sxe
	item e_tag
	item eth
	item fuzzy
	item ipv4
	item ipv6
	item nvgre
	item raw
	item sctp
	item tcp
	item udp
	item vlan
	item vxlan
	action drop
	action mark
	action pf
	action queue
	action rss
	action security
	action vf
