Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD298C9EC97
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 15:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8DD640156;
	Mon, 12 Jan 2026 16:03:27 +0100 (CET)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52]) by mails.dpdk.org (Postfix) with ESMTP id 1BC0D40041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:03:26 +0100 (CET)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-5eea9fbe4a4so1241817137.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768230205; x=1768835005; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=REQX0sdsN8UXq1+E4FYo6HcDENxErQt5/S4ihNkKBlc=;
 b=cKTI4xef8EbsIjyIloIOLb7fJwq+c9znJXM0yacD9zoiq5hRaxsBAVwYETmgt6T3wp
 SlnOOsIFYSev+aJsFoSEUQHiRVVqC6tZowP+5AO+1mewlfRCpseHz3RO1nQCQ23nxqeU
 2VXXmUF6Qf6+AZ4Zl8u3oTNui+1kUUD5vvAb3Zn2ODLFm6glU4EH5Tu70W5AbuQQUPf7
 OdDjKBxUHBTg7oWvTXdbrBW+TqICzvK2dLP6d26zJ94WQ7gUNkSK1G2naxLHXMLNTbDC
 Qf4N5dxdvwqV6zxM7+Bp1zRHZQnpby1Hgq+TNUEi+AZdNxtWge28huUd6Q3DBF7mh2Qq
 EW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768230205; x=1768835005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REQX0sdsN8UXq1+E4FYo6HcDENxErQt5/S4ihNkKBlc=;
 b=Ma2usUglFO7ZR/vKCe70QTJ5eSiPN72BR7APJW97HlXot2mka3Jl7k/HeVlwp7fSi7
 6/arNzpqoBUpqeL1ioVeKumx7803RKdRoakMoxgCXrARhD6xd0m2K4mZXKs8aY5YSvLM
 k17QI2TG2ysKMp5rCXFzWa7RQzMQeHj4pP7BrWx5ibyM7e2H9Bhq7E8aK5BoarG4f0aN
 rJRjHNMDnyYwW/1o2Qe33fqTVYWZYYLr4uRgZm3JRRPVHGr/+sO1Ai1KeHs0EgTfCGYR
 wVFM0TWv+/fqTgddzARzGt3N743oy1lP1NLcRmQ0wMzxkyIH7+rY2ufUkw9E/FyIyEfX
 YeGg==
X-Gm-Message-State: AOJu0Yz7Ix6tlwahCJQQyJzkyTE4HSNbaYJnJCzL3sA99Js/kU9DtXH+
 VY8EjEAcqkLzq3WTqX0Sg2KVilYLGNcwo2fVvFh+WW136Vrfgb95fx0uIxgTUVK2/XTuVsjz6SC
 ntsDdSkxwtomBz5SV6oH67sjHbFdpjoLo7Q==
X-Gm-Gg: AY/fxX7PEHLK92fBpUR6uI6OOlgdv+VBqNmMRVUTIg+ygD277m0iXw3dCuyaiDgbW2j
 VPZPVERNdofTcf+4QLaY1As0vyjEnKHAKjZKIM7YFjBz9TBN4NI9f5cTfYcPZoerpCgZ3F3m1Wa
 1penhA5fCAOnZoi239xSKy9H5qWLKKqHjrtSJDKIzynhlNG9RfeIvwO8wr303PNzl1IRjdb1WBM
 8iMKl/18uxikjfZBP3ISkjZx1chOJ5bxSlVM9QW1hSktBQcDNldMs3e9J8CrF3eVlw0ki1+qpP2
 ycPCJQ==
X-Google-Smtp-Source: AGHT+IGeAo6s+ntkN2Dp782YuZiyFKUYnH2HFLVlWYITU21z6rqNV9zQDRszRjS0RqzEJredliN7/TAeEnE0ApoXeDM=
X-Received: by 2002:a05:6102:b13:b0:5ee:a0e6:a9fa with SMTP id
 ada2fe7eead31-5eea0e6ab44mr4846588137.23.1768230203921; Mon, 12 Jan 2026
 07:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20260111202709.9006-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6564E@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6564E@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 12 Jan 2026 10:03:12 -0500
X-Gm-Features: AZwV_QgrvbX5YRwvu5e3mWjzM8vUl0Dm3FrjQOz3RZlv_gbUVQFv2WFdOTkNjSk
Message-ID: <CAFn2buAk4WFco=W3im9cS16QWJ5mgdmY=W6pxoOb_pF_uPomGg@mail.gmail.com>
Subject: Re: [PATCH v13] net: optimize __rte_raw_cksum and add tests
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
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

I realized the v13 approach isn't fully safe as it may dereference
memory in unaligned fashion and doesn't use an unaligned safe type.
I submitted v14 as a more general approach to address this issue.
