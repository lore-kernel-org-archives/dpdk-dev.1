Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33F606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QmpFQ0jO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51FEB4026E;
	Wed,  4 Nov 2026 10:29:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id A9F6940151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 10:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793784594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e/whAFSEbSQNl7ikspAE/jfALbMJAlqd9aeC46OZF7Q=;
 b=QmpFQ0jOYsn8Wzg7xEZpawC5e1sWqFqzRGz/YBEFSSHF7GGXKALzeS7K6HqhASl1MEnWc3
 PX40Xq0f0g4NvFt1mv8SsqLLC+XZ8+2C10RwoOT6SQal+x3dwGS+khUYrLGaybLYZHNijS
 6pDhUFzYOdSr2ZrpN4O74j3XTnVNl34=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-vKzhUKenPMOXvpbQhR-nfA-1; Wed, 04 Nov 2026 04:29:52 -0500
X-MC-Unique: vKzhUKenPMOXvpbQhR-nfA-1
X-Mimecast-MFC-AGG-ID: vKzhUKenPMOXvpbQhR-nfA_1793784591
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3accf0b1addso3365341fa.1
 for <dev@dpdk.org>; Wed, 04 Nov 2026 01:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793784591; x=1794389391;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e/whAFSEbSQNl7ikspAE/jfALbMJAlqd9aeC46OZF7Q=;
 b=vgn0ybMpmP12ny88sR1zDHUyzkS93JAn77i7qfg1C8GnJyFpkxErv0Q0/KN8AYNnlQ
 9ncPgY4DqemOxggGY3KWvz+KMVHe0IVplSVWTiJO8LTo5yUEvjikbCzzzT+rwvATo45i
 F2pf/VAui/c/whSAlt1XvaWZnxaVTx2F81grjyVRMl0TntthuOgkGTxNWV0urS1C99ZG
 jHo6lenrh1BV9xaFMbiR7N8DG6hdcRoSVihoVTgUoowTe5JjoNUeIHN0o1ZBuunsetlU
 PbQc3Aa0kKvz+LpbLWq+G309rkjkvNs3dv60y/kEJZq6y9mZIccFY9XqhmiLdV+tA4zn
 db0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2YQXUYzuAjDexFRIWhIR0G94r1kJexabxl7cgO1YTQFAFPlKX65aCB+mAX9BlTBjFc+0=@dpdk.org
X-Gm-Message-State: APuU4Z8xL/zZ5CL3GixlpXsrPr5UVFzMhGwGdhjylaIq2vKxNX6x9C51
 8GjMOWhiEI1/6Wth0wqj4W2tdtWe5e2CJsXM0BYWnjLovslhSIAZlzRSMUcv8nCIymQ/IFK+vfe
 4vXqHtD4hxqDb2BbJfo6QdJXmr+L1Xf291gNk5RGay9I2C2mjluFpWzG1wRuIm/kDb0w1f9Id0q
 2zNrU+aNok/hUTLlt+ssY=
X-Gm-Gg: AYBFou3C1lllDf3alCSUIwqlfVYidcorSYPOSG2d68+9QjfDdTC4UZqORtVhKWFMr3s
 DleJ/4DE8zfnvvh3nKgdyp2lkKS6L25FQ7bXkmuJX6NpDKppsxRNyQbYbM9QcClAbOxyPgfT0d9
 6vedfpDeME618YR/pqphx7vLPucoma57QBQjin/b7QAfxSR7uuuelT7ASTN/LFEDjEhu3Nft3Fm
 zpNMx8ZBxJRElruKQPNq1SFQQnJpgWS0/6LsIFTFYv9+sAn
X-Received: by 2002:a05:651c:211b:b0:3a6:553d:cb1c with SMTP id
 38308e7fff4ca-3acb7aa6bd5mr37039331fa.12.1793784590896; 
 Wed, 04 Nov 2026 01:29:50 -0800 (PST)
X-Received: by 2002:a05:651c:211b:b0:3a6:553d:cb1c with SMTP id
 38308e7fff4ca-3acb7aa6bd5mr37039211fa.12.1793784590331; Wed, 04 Nov 2026
 01:29:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261104083450.215d2660@stephen-xps.local>
 <7add359d-c77c-42ed-8e92-d5d496b8bcb4@huawei.com>
In-Reply-To: <7add359d-c77c-42ed-8e92-d5d496b8bcb4@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Nov 2026 10:29:37 +0100
X-Gm-Features: AclHuK9PsgPLB01xp70KrDA3AbitCnYBAwfA2EsWN7xOwfsAMHCl9GdS0VvBIYA
Message-ID: <CAJFAV8w0rALL5A7BoewJRcEqY-=ZGyMONTTFbgo_OSuf3k7S+A@mail.gmail.com>
Subject: Re: [PATCH 000/227] use NUMA node terminology across the tree
To: fengchengwen <fengchengwen@huawei.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <chengwen.feng@linux.dev>, 
 thomas@monjalon.net, konstantin.v.ananyev@yandex.ru, dev@dpdk.org, 
 Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GfdsrtQDWyB2dlYNWPDwv0lVijmPwHBFzgMr1cGcvW0_1793784591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 09:56, fengchengwen <fengchengwen@huawei.com> wrote:
>
> On 11/4/2026 3:34 PM, Stephen Hemminger wrote:
> > On Tue,  3 Nov 2026 22:49:18 +0800
> > Chengwen Feng <chengwen.feng@linux.dev> wrote:
> >
> >> From: Chengwen Feng <fengchengwen@huawei.com>
> >>
> >> The DPDK tree conflates CPU sockets with NUMA memory nodes: public
> >> APIs, structure fields and macros are named after "socket" although
> >> they actually identify a NUMA node (e.g. rte_socket_id(), the
> >> socket_id field of rte_memzone, SOCKET_ID_ANY). This naming misleads
> >> application developers and pollutes vendor code that targets NUMA
> >> topologies.
> >>
> >> This series renames the terminology tree-wide:
> >>
> >> Foundation (EAL):
> >> - New NUMA-aware functions are added: rte_numa_id(),
> >>   rte_numa_count(), rte_numa_id_by_idx(), rte_lcore_to_numa_id(),
> >>   rte_malloc_heap_numa_is_external(), and friends.
> >> - SOCKET_ID_ANY becomes RTE_NUMA_ID_ANY; SOCKET_ID_ANY is kept as a
> >>   deprecated macro alias.
> >> - The socket_id fields of the public structures are renamed to
> >>   numa_id, keeping socket_id as a deprecated union alias (so field
> >>   offsets, and therefore ABI layout, are unchanged). Affected
> >>   structures include rte_memzone, rte_memseg, rte_memseg_list,
> >>   rte_mempool, rte_hash_parameters, rte_graph, rte_service_spec,
> >>   rte_acl_param, rte_gro_param, rte_ipsec_sad_conf, rte_member_*,
> >>   rte_bbdev_*, rte_cryptodev_config, rte_compressdev_config,
> >>   rte_event_*, rte_ml_dev_config, rte_rawdev* -- see
> >>   doc/guides/rel_notes/deprecation.rst for the full list.
> >>
> >> Libraries:
> >> - Library-specific APIs follow the same pattern: ethdev, cryptodev,
> >>   compressdev, rawdev, mldev, bbdev and eventdev gain NUMA-named
> >>   device APIs (e.g. rte_event_dev_numa_id()) with the socket
> >>   variants kept as deprecated aliases.
> >>
> >> Drivers, applications, examples and documentation:
> >> - One commit per unit; in-tree users are updated in the same commit
> >>   as the unit they belong to, moving from libs to drivers and then
> >>   to app/examples.
> >> - The programming guides and API docs are updated to the new names.
> >>
> >> Compatibility notes:
> >> - The deprecated aliases preserve source compatibility for external
> >>   applications for one release; they will be removed in a future
> >>   release, as recorded in deprecation.rst.
> >> - No ABI break: the deprecated union alias keeps the layout
> >>   identical.
> >> - Device arguments and command-line options that literally use the
> >>   "socket" name (e.g. --socket-mem, --socket-limit, the
> >>   socket_id= parameter of the bbdev/compressdev vdevs) are
> >>   intentionally NOT renamed to avoid breaking user scripts; their
> >>   documentation still describes the existing parameter names.
> >>   Feedback on whether/how to migrate these user-facing names is
> >>   welcome.
> >>
> >> This series is based on v26.11-rc2 and developped by AI.
> >>
>
> ...
>
> >>  lib/vhost/rte_vhost_crypto.h                  |   4 +-
> >>  lib/vhost/vhost.c                             |   4 +-
> >>  lib/vhost/vhost_crypto.c                      |  16 +-
> >>  lib/vhost/vhost_user.c                        |  22 +-
> >>  905 files changed, 6113 insertions(+), 5439 deletions(-)
> >>
> >
> > Maybe a single coccinelle script would help here? Rather than trying to look
> > at so many patches.
>
> A coccinelle script is a helpful idea. I will try to prepare one.

Well, maybe.
But never a 200+ patches series again.

Putting aside the way it was submitted, it seems this change is only
cosmetic, and it was not announced in a *previous* deprecation notice.

Why do we need this change?
Why now, in this release?


-- 
David Marchand

