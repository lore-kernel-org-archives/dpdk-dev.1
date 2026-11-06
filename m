Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE6606D80B
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h9dOUnwK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE219402D8;
	Fri,  6 Nov 2026 19:43:58 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 14EBA402D8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 19:43:58 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-93f3c8958d5so118635485a.2
 for <dev@dpdk.org>; Fri, 06 Nov 2026 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793990637; x=1794595437; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f0gNt+lreyzSAM40L+Yc+H8FSbcpA+qmAMOHExL9FDk=;
 b=h9dOUnwKoA+aYuHBWbS3shiR1T7Q/b0+H3hPvx09c0aVQHtXLmUMiXhB5DPzWZ3gZW
 RBeSei7+cWbO7BoyApX0Qx3OTWqdDtAWW9Jfdis7QstjGT/CLnWH52dK9zFKg83ne0GR
 ZKTJKqDwQDn8H1/x/GftvOedXki7w/tEbhXwXc5axW52M4PG0iIvpwMYhJBwQuY0jZcB
 GjZw94N6n5rVA/SBBmnJCHKPO18jRneFI3mijIlNAl2S/9diTrjEx3LYO+RYLu/jWCe8
 D8/c4wGzA7F/wJfw5oOQGJnDDAQxCUm+e3pPqrMh9NGirmkt8gVHPsTsVt+D5dozWIJW
 o4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793990637; x=1794595437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f0gNt+lreyzSAM40L+Yc+H8FSbcpA+qmAMOHExL9FDk=;
 b=PPX/t3w+VKl+lp6PsVkGsU5uLFTn2hnP3z4bWQ771C6oWlJjwHMg0xAxqNIx4aT553
 fUegpMurJbVyqKjxS/Ym+KmhkDQetHxKPUeOjoa6jEaN+jypM+62tN45GOaDLs1/q0Sm
 G7y6kWfGcgDftxmAs91dmUxjbYTWGq/Lxs9L5Ivvlu1FkMk/EHSBIaEK6wMzQz4JmU7w
 HViQWNppUQWgbXlSp9k6GJLKighnpac4yfFZ5HFGWwo0wJS41gTky2xl6GzXHgKvewUK
 eRk4dI1VsLLyqKO8bbCYrmw2WFQqnQ+KfHQYXpG4VZ23JzBvMGMtZ85nC1nLfHYbF9nB
 P/ZA==
X-Gm-Message-State: APuU4Z8a0smUcsODICnx7/9vMkffHesQeBHcfWBj0oyNcMkqyWUgOEK3
 L+ypogU1I0WVafjUCIpJUpd5ni5ESOXJ99FYF5+nix+HPLKqbJCjXqdmyshbXZT5
X-Gm-Gg: AYBFou0oLInjQSfTnprQmaRgilTQ2jkGxWRPVWbC5pAt62HmytBCfwyW0UAkrVNxHcf
 cqlHZ//z2V295bWMt9HxKOK6s58VioJP9G9nl6ezNQnlFqpdGTOGKZ03h5haUJfTNIf9EI7GN8x
 5/uXnp8yMVJ8TKzhaabxqIYu8NcGYNRDu7uUJ0vQ6ilmfqrO557Kb+GjZJ4JDaha6SN/WM+gxfS
 hhKsrRFYspd96fQelxhGe7BAaeLQNwliWNW2s0xGUZNT8BKgLO+LHrE9GSXQRrbvyofjhRzah2S
 UyDCN5azK8OyoO0mV5arNuYV2PxCD2ObB4fc8xfD0hIBuymMdaXZvXMTnRpGo2wInqgR3d7j4kV
 ZnUvdn8MRN3Sw7sFcUtv17kVgBrSrlMkr9zRx0azBiGEqF0rYq3NLUFxHdXxhZNIEQD3FVJ399y
 B2uWh0E3EoU9iYixlC5gpWDmW2BItNA14bamJWnHTydMLKMVkXawhV0Cj4sthlh0zSKWia6q1Xd
 g7aiIet9IQcycuVw8QrakCaUkADm+SGMy1MP3h8PqxbZxQUrtjEdJkWIxcC6mA0/cy6sKFJ+bS7
 PLzwNz8ik1gaGQnSOvNHfbAFXBkqBeWwCzu1KMy73NQBMPChJzHjnNDqJtE1ewab+/Ug1cWVbbY
 mliu0ccgbfoaul9MXRQk92jpOdkeJH/Z7qMCk+WogcCz/Ivbg4chD0pc395NUMsmLRgg1SoESpB
 5qAj1CVDJvF26BVc9qjheb
X-Received: by 2002:a05:620a:838f:b0:93c:5bfb:9a80 with SMTP id
 af79cd13be357-945f32e9165mr516789085a.3.1793990636587; 
 Fri, 06 Nov 2026 10:43:56 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945f599bcccsm203070185a.13.2026.11.06.10.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:43:55 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org, =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: andrew.rybchenko@oktetlabs.ru, olivier.matz@6wind.com, stable@dpdk.org,
 rsanford@akamai.com
Subject: Re: [PATCH v2 2/3] mempool: fix dump of unpopulated pool
Date: Fri,  6 Nov 2026 13:43:29 -0500
Message-Id: <20261106184329.2095115-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65AFD@smartserver.smartshare.dk>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103173543.130142-1-rsanford2@gmail.com>
 <20261103173543.130142-3-rsanford2@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65AFD@smartserver.smartshare.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Morten,

Thanks for the review.

> mempool_is_created() should be public as rte_mempool_is_created().

I made the change: rte_mempool_is_created() is public, non-inline,
not experimental, and the rte_mempool_walk() description refers to it.

However, devtools/check-symbol-change.py reports:

  ERROR: rte_mempool_is_created in lib/mempool has been added directly
  to stable ABI.

How would you like me to proceed?

Thanks,
Robert
