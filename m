Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF0606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gwMrMb/Z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2E5C40278;
	Sun,  8 Nov 2026 17:58:24 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mails.dpdk.org (Postfix) with ESMTPS id C816D40264
 for <dev@dpdk.org>; Sun,  8 Nov 2026 17:58:23 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso69167a91.3
 for <dev@dpdk.org>; Sun, 08 Nov 2026 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794157102;
 x=1794761902; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mDRfKXom6leUuXIdDQjZQzuAOsBfhH4qM+lpio5OBJo=;
 b=gwMrMb/ZfVntZA3kFVAKsQNNENrVoXBVL3nxFE4OvrshvpYECbwYF64Bcl1/TxgEHY
 6XrVSKl82jyyQFAX0SXKagWY+hA+2zALjSQtzXjc2pZ7s0/NILOaintSu0Z984zymxTl
 jh7O2g9y7G7KEBEJY6bP+K5l2z7NAE/4sTNFuUQcdbmlI7Uc8jYwXoIgfHPDB+TZwVH+
 tXMC5oNyMmSrmXMjKzUmUaSOhwidNQ5TDfzTPAZLpQJyYeKECqShD7qaq9sUdYBTZZtj
 aoTrfR/t5as9kbkzNkfzQx93m+te8Jo865f7MWaBdjjnCe/1VCGeHa3qtKGskIBIvnAe
 zCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794157102; x=1794761902;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mDRfKXom6leUuXIdDQjZQzuAOsBfhH4qM+lpio5OBJo=;
 b=WEKBnMjnEnDQ7V+SA7AeWF3baKHokry2DrEEA4GWuXK2pfarqCTpuzIxHAhZ6/V1y5
 1K4/BZQthnJ/802/d8GXnaaXFtE4m0cyedSWgYk+woIzDONdJU0Af/gh652Lqhf24krv
 78brOd4sqlPV2CLTOARZZboQ1JIQg39x2Fa4JqphQVLe5twpAK+ee9OzYcgcTL9XJmda
 IOOcaQ6nBVZ5EjuJT2OhWI2tmtZWeRZbjVofcvilPePpYtKt0PmkZm1HdXp+CDaMMW9i
 qfu131Q0KGZCx0Njo8O26FL8TWNxl8V4iFXUWyAHBAPO3HxrH/QkztftummSGyOWWYVu
 5YJQ==
X-Gm-Message-State: APuU4Z+cKZm2lNmB6c56oPTQTqn40tAsUaeoKuvBiFTwzKIx42k0LNNF
 MronfTMOGFqnRIMDpj/nKLHeHJlL/2vUroZMxbWUOgrLOZKY0/RyfG4b3eMTYxYQols=
X-Gm-Gg: AYBFou12LPF8f6Gn7G101rbqPy0TeOZBwsOW5OcOnEQecf1Kc4u8txi5J1/TmogQbs3
 6kTdf9GzflbrxOxFE0IDFoVcDSudGX4a/NJtjLu7HDCxjM+5dPeya3lCzX+MzElw7J29csxJO+n
 85i03Q3q1YtPhFv+BlGlpAX0kR3cQh2/K8JShSKzk0llAqu0/Z3ZoP9iJDYZ83LDw3o+SbsvlZk
 z4Ho8X5h38mpln0L/J6teU5TNlQpeXHhpkmzXJWECUG4zZrGYKPt+OYvEfar8ED6YEXgncAZ3un
 Au5+tS5BVkiGJ4OHxY+lBW+aBP4H9yRwmvI/LcNQCqF8IupNlICe+enrfewQ1xTbg8vmJmG8TyV
 UQiWc6ndJAR2XlJl78fqnKqhRa9Usv8wPqa/Xx6YXyIOKYezbH2m5Jq9DaVEdooYLnftDA/qehG
 Z1Jq+NS4RjCdLqiLTDhMLnUmpeR8Yevc97xG1aRAYY/Nbkf5YFiEV2FTGNfDDDE+53UjmjvbewZ
 zZFTnWVQI8Bo0cgFrOZq2MQL5e5l6UD+gRnqjP2+1BqLIpngNhJ5e5R+bJMs6sThEemJwoDHTn8
 r78d9nDD+rDjaYbljitGHUqp8N+iuL95GIjAnH40X7q4WsPdvyNaRccG3gmR3+vzHOdOaw==
X-Received: by 2002:a17:90b:4a4f:b0:3ae:a531:4e73 with SMTP id
 98e67ed59e1d1-3b12d105bd9mr1670903a91.7.1794157101960; 
 Sun, 08 Nov 2026 08:58:21 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b127970954sm3625404a91.15.2026.11.08.08.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 08:58:21 -0800 (PST)
Date: Sun, 8 Nov 2026 08:58:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 0/8] net/zxdh: fix some issues reported by OSS scanner
Message-ID: <20261108085819.2e297093@phoenix.local>
In-Reply-To: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat,  7 Nov 2026 11:04:40 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v1:
>   This series fixes issues in the zxdh PF/VF mailbox handling that were
>   found by a code scan of the driver, reported to us by the DPDK
>   community. All of them are on the PF receive path, where fields of a
>   message written by a VF into the shared BAR window are trusted more
>   than they should be, plus two ordinary local bugs the scan found on
>   the way:
> 
> - The dispatcher hands msg_head vport/pcieid to the handlers without
>   comparing them with the sender, so a request can be aimed at any
>   port (patch 3).
> - The header module_id is checked as 8-bit but indexes a table as
>   16-bit, and the async ack msg_id indexes the 256-entry seqid table
>   without a bound check; both are out-of-bounds accesses up to a
>   function call through a wild pointer (patches 7, 8).
> - The receive buffer is allocated with the sender-declared length but
>   accessed as a full struct, corrupting the heap; and the async
>   no-ack exit leaks the buffer, allowing a guest to exhaust the PF
>   heap (patches 5, 6).
> - An uninitialised DTB entry is freed on a flow query error path,
>   and an uninitialised multicast delete flag makes the PF delete the
>   multicast entries of every port whenever one port leaves a group,
>   with no attacker involved; the latter is a v25.11 regression
>   (patches 2, 4).
> - A VLAN id above 4095 from a VF message turns into an out-of-range
>   ERAM row index (patch 1).
> 
>   The sender check of patch 3 was verified on hardware; it stops at
>   binding the request to a VF of the PF, a VF forging the identity of a
>   sibling VF of the same PF is left to device-side protection that is
>   planned. Each patch has been checked to apply on the current main
>   branch.


Overall looks good. Running AI scan locally had a couple of things
you probably should look at

Subject: Re: [PATCH v1 0/8] net/zxdh: PF mailbox hardening fixes

Applied to main (v26.11-rc2), each commit builds with -Dwerror=true.
Fixes: tags check out against history; all are in 24.11..25.11, so
Cc: stable is correct. sizeof(struct zxdh_msg_info) ==
ZXDH_BAR_MSG_PAYLOAD_MAX_LEN (2036) confirmed with a static assert,
so the premise of 6/8 holds.

One real problem: 8/8 is missing the hunk that is its main fix.


[PATCH v1 8/8] net/zxdh: check msg id before indexing the seqid table

Error: the commit message says the check is added to
zxdh_bar_msg_ack_async_msg_proc() and that the reply-path check is
only hardening, but the diff (5 insertions, one hunk) touches only
zxdh_bar_chan_sync_msg_reps_get(). After the series the VF-reachable
path is unchanged:

  static void
  zxdh_bar_msg_ack_async_msg_proc(struct zxdh_bar_msg_header *msg_header,
          uint8_t *receiver_buff)
  {
      struct zxdh_seqid_item *reps_info =
          &g_seqid_ring.reps_info_tbl[msg_header->msg_id];

zxdh_bar_irq_recv() still reaches this with a VF-written msg_id for
any async ack, and the free_id path then calls
zxdh_bar_chan_msgid_free() with the same unchecked index. Add the
check before the pointer is formed:

  static void
  zxdh_bar_msg_ack_async_msg_proc(struct zxdh_bar_msg_header *msg_header,
          uint8_t *receiver_buff)
  {
      struct zxdh_seqid_item *reps_info;

      if (msg_header->msg_id >= ZXDH_BAR_SEQID_NUM_MAX) {
          PMD_MSG_LOG(ERR, "msg_id %u is invalid", msg_header->msg_id);
          return;
      }
      reps_info = &g_seqid_ring.reps_info_tbl[msg_header->msg_id];

Looks like the hunk was dropped when the series was rebased onto 5/8,
which rewrote the caller.


[PATCH v1 4/8] net/zxdh: initialise multicast delete flag

Info: the paragraph about what the compiler does at -O1 and above is
a claim about codegen for undefined behaviour, not something the fix
depends on. Drop it and just say del_flag is read uninitialized when
the group loop breaks early, so the entry can be deleted while other
members remain.
