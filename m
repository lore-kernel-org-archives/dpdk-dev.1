Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F9AC43327
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:39:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 695774067B;
	Tue, 30 Jun 2026 15:39:23 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 3726D40654
 for <dev@dpdk.org>; Tue, 30 Jun 2026 15:39:22 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-13a97ffb312so3054378c88.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782826761;
 x=1783431561; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLBeGyBW7FZqrXiv/mtaIq19kHxIxeZruofdAHm78p4=;
 b=MurkH+2sR0O/EuITDGWrAd67PZpq9kb6HtK1WBGsbU0j5Xwuz9W9rCy9CzvhT2+Iwv
 4kCgr+6r7VRGTLMXpMgdUKfyF6yxcJOXoamJ3tUYakipxKSr/lAWR0WSkek2w2itmpbk
 ebi+rhaVtihvRF17U2Lyxz/e0BYBuHEhu7cJwR9q17XdaHZMRUwPzPexBQgmm4fmkBa8
 tj+3gTjeV5/lReD4PZBPVQGMzyX9SPCyewrwrdkaEhesTRZbqOH2nWFfD4pcWks/Kt4s
 hCSYCwkPfCvzlUAMwnxxlXiMSMV1eI6FMpR6zKC33zJrYe3jdMa7REPQQtsTiC/uWkyl
 3WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826761; x=1783431561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLBeGyBW7FZqrXiv/mtaIq19kHxIxeZruofdAHm78p4=;
 b=BbjodxCqV34AMkX3m2H+p9qwBTAzzdgKfFL5yFbeeBqbfiwOlPJHnU9K/9WN0TpNtt
 LTprIowV7ae7A6m3cYlzLwBPS8LjlnV5d3fZYgxWBIC3OFLLYgbOtDFCFkT16cIEU94g
 yo5YZbeL6I4vO+eQNaiTWf06JiwgcC2LIlahUwk0GrJo9ahnfWk125JupwWHNO/IueUc
 RiXrqbv5f3bvtniJaDMJEj3BLa0qFNVUgF/Ni6nivr0/IZcEphafGSlGMgz4fiRJk8Xo
 6luCjqU/SnDj9QefBYZZt+7G984IjLnJiK4n7uhtAgjrl000KK+B2oUpgVXL9V42JTfw
 ymBg==
X-Gm-Message-State: AOJu0YxQPI9G45xIgfheDYuyvvrQHeCY1PXVsViVKi3smoJX6wHvgjBc
 nyyJwvrt4YNx9ZhG9/dNrJ7QXwhaXVrL7BcniXkB1bRNxLIIkc6Q/WzSPquMFMImWgk=
X-Gm-Gg: AfdE7cnWRxwFfInxhh+MqI8N4/T18aGax+g/P2vwm79t0YzlG/x+72ywC6p+Nw9ptpT
 FslZeYPzKZVmtUzl0ICxHLsqQQwXaPKkVnmbZlmSwWUDg1BoA80pme+Wn21hDrQX94dwQhlwjDB
 NSRe2EYhx6gkt8BTHWSBcl73pu0gGd2Qu+ZVRR3CalaGbBkpb9RA/Y4BkojajRkxEgE2vm353J+
 oruQpoc1POAenbxUme0QivehLJf2i4b0CnBaDJDFlMt+zGMsP1sqdjtnlP2anaGptV/K8Vl24mO
 VDvTFCGgKQkxK+fGSMUyHkKIsqUzGoCW2P7w1GyRNQJIVqod9F2k4bW2LLpj5hDdvqw1ggfKLvo
 hnOJmbKQfF69zJZdFSEVV2+zyEDl20DncF94Q1M/nraYMbyuCyFUWL6jbewn37D3K9DpV/1SAY2
 9LWuA2loO5gG4Z6LnFUA8f87QKmAhksTPsyMCh0srETWOA0HW+EgI1lw==
X-Received: by 2002:a05:7022:6894:b0:139:c4e3:947a with SMTP id
 a92af1059eb24-13b2a176442mr2249653c88.15.1782826760902; 
 Tue, 30 Jun 2026 06:39:20 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab0fc3fsm8914818c88.2.2026.06.30.06.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:39:19 -0700 (PDT)
Date: Tue, 30 Jun 2026 06:39:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, sachin.saxena@nxp.com,
 mb@smartsharesystems.com
Subject: Re: [PATCH] net/dpaa2: drop the fake software VLAN strip offload
Message-ID: <20260630063915.516fef48@phoenix.local>
In-Reply-To: <20260630124945.399268-1-maxime@leroys.fr>
References: <20260630124945.399268-1-maxime@leroys.fr>
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

On Tue, 30 Jun 2026 14:49:45 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> posts to the store buffer while the line fills in the background, and
> the rewritten fields are forwarded straight from there. buf_addr has
> nothing to forward, so it must be read from the line, whose fill is
> still in flight, and the read stalls. The ethertype read that follows,
> on the cold payload line, stalls again. Read later by the application,
> when the fill has completed, the same read hits. The offload just
> performs it at the worst possible moment.
>=20
> Measured on a single-core port-to-port forwarding test over two 10G
> ports (one core at 2 GHz, 64-byte untagged frames):
>=20
>   - throughput 4.22 -> 5.00 Mpps (+18 percent)
>   - IPC 0.93 -> 1.25: the cost was memory stall, not compute
>   - L3/DRAM-bound L2 refills 319M -> 200M over 10s (-37 percent)
>=20
> perf confirms it: with the offload, the buf_addr load (the cold mbuf
> field) and the payload load account for about 84 percent of the Rx
> burst's L2 refills; removing it, those vanish and only the inherent DQRR
> dequeue misses remain.
>=20
> Stop advertising VLAN_STRIP and remove the rte_vlan_strip() calls from
> every Rx path. This is a behavioural change: the tag is left in the
> frame, so an application must strip it itself, on the L2 header it
> already reads.
>=20
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

Applied to next-net
