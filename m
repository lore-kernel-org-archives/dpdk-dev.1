Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF9BD19510
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4431402AB;
	Mon, 26 Jan 2026 19:28:51 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 25B46402A0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:28:51 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so44524315e9.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769452131;
 x=1770056931; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=QyOZtBooF4Os9sbRjjdt3dfVf6E3CESrlPqFXDqtZEk=;
 b=dNM7v5XQX2k2a6+r4JqMa7s7CrQaTs0yvxXE771Qg6VTRFvI9yLtoC7DoGIHcQZ6bz
 d1g/TBajCxEopvJ/NSVYxrG5p4nxgHA4W9AUjtAdKxJqF0dXOZosxnLwzEyEts/becuU
 xkqFHiLRnn8X+9VWDWL1zdf0HPD5LgtcaoBVhPg5EoZwKtiMkWucFkIHbaNQbiAsDfEU
 qdWnwKLoPCFuRY8aM7hGWbT7IELXr+DEapU/kKzWusVKrYm2JwcDWU0/pTZG9zD86XdJ
 6o6tSFgiWJ9q/uakcyyjR7JRACiKKOKyfhF1NyDqaXt7xWXvff6TST6TTf25YX6xymGg
 dz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769452131; x=1770056931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QyOZtBooF4Os9sbRjjdt3dfVf6E3CESrlPqFXDqtZEk=;
 b=GsTM52t6yI/V8Zf0/OicCQCJJBUcQ1d1kO6q9JuFp0h03Wfu+JX+IvvgM2Qw+Bze1p
 LJ2/G41caM2ygRJQqh8e0kQkWw5sd5Frcw0kFyCyvUkrdYG9Wbe3HfhAQMgbZVuSY2e0
 BlbUAxMBHk7J688RuShDeMcD3bz0BhjvkAGSxhxs6Ijcqo14NbcdbtZBpoGsmISg5Ntm
 6ke9cqlpK+rUzSH11nA3f+lEtXvGf8CRvwIR1jl6Wv1fQEP24Yu3SQA0tXTAEksHMRdt
 t8d9MKtdbe14KgiYB0VraQg8ODtw7EBuEeNyaBjJuW/KSb3ZTGoQcwBx79b2RuKDB2e4
 tFbw==
X-Gm-Message-State: AOJu0YyphCpaLcPM3CfhT9py9hzoDvMvjBFfADxnooQkWPbtylfn/W3d
 H2p4PtM1JoRQDTC+t/ZwPEBJuYqAPpThezcyiUz9VnjnIHIoiwgVygIYusxHZTHbd/2eqQIX5pc
 gYUED
X-Gm-Gg: AZuq6aKBz1upbbh7ojPFSYMLx7VC+6F43GTSJIjHN5a6lMeF+Gz+7CpIcZPkemysJm/
 BVOaPPMnSSLhX+MeQgMB3D2Z5/fe8jBELwaRIdCt2ke35Uu8gBzY3SvY6/ESM51yEMJfdYJRCbe
 8ilP37atAlt0KMGErNR1pMsVaVHF6gqHtFXhY4dRl1okvPP88A6JTxKg7J/QvfHLBXRScvKtd6c
 ekpE/2EG3N4FaUtzPJgML/tQSZ7BOMJs19NZJd2ujbQdA9FupgytlesXvlX4+As85BtETzT20tw
 5Ro8IBANJni6aBk8Z1ULBXaWhp9kHve9dZyH435823tAX26eo/GHkafDCUf1pd/rsLXExpIGeeV
 MT4Mb1rI6e3c5Sg12ZRcI9CKUjDumAawykcu4Bo2IS7INHJwb/2WIqSqm1bZYcSIPD7a/1rnwFV
 KCRo1xUHN+enkX8Hx6h51n6dYl3REHNUTqFgd8HpoAB7T+J+vJ4xZ0
X-Received: by 2002:a05:600c:348f:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-4805cf668fcmr92504885e9.23.1769452130755; 
 Mon, 26 Jan 2026 10:28:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c0f3f7sm9739905e9.13.2026.01.26.10.28.49
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:28:50 -0800 (PST)
Date: Mon, 26 Jan 2026 10:28:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [REVIEW] net/nbl: improve exception handling for the mailbox
Message-ID: <20260126102846.47c7f651@phoenix.local>
In-Reply-To: <20260126181838.102532-1-stephen@networkplumber.org>
References: <20260126075815.178216-5-dimon.zhao@nebula-matrix.com>
 <20260126181838.102532-1-stephen@networkplumber.org>
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

On Mon, 26 Jan 2026 10:18:38 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> ### Code Review
> **Warning**: Missing NULL checks before rte_memzone_free()
> ```c
> rte_free(tx_ring->tx_entry);
> rte_memzone_free(tx_ring->net_hdr_mz);  // Could be NULL if setup failed
> rte_memzone_free(tx_ring->desc_mz);     // Could be NULL if setup failed
> ```
> While rte_memzone_free() handles NULL, this is not documented behavior. Better to check explicitly or document assumption.

Ignore this feedback. It indicates missing comments in rte_memzone, not your problem
