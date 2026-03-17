Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58EFB5E97
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 00:42:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 588CE402D6;
	Tue, 17 Mar 2026 01:42:19 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 9D1B440270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 01:42:18 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2b0484a6de4so10349185ad.3
 for <dev@dpdk.org>; Mon, 16 Mar 2026 17:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773708137;
 x=1774312937; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXEnpgFnvJvrdHFM9VkdJvHe7BEj/kxiGdjSYcigpbU=;
 b=1f71fUgkHYtLeo/Fk99EOnUsMmZxzvSkIUOt6HVn8H00aSsTAhaCGx01zDsWeFj0bQ
 zI6RwJeGX530LWJuRAWdeb7f2kGZnIiBZ0csTM2XW1XWrdHcMs5HHLcy7XNiO/etkA8P
 FT9XaZqyryVGnGe1UDDBOrWmNE7IlHAqHkK6EIEFMQ0fKWOIAPkAgpJ2QCLb6hcOehFQ
 YmkEhystyMxQQniqwpfNzLTzT8f8DA1W3Uoku5m1KK5OzjJbfdoTvVXkUK3hYE+q2C9Q
 u9ciPWmST3WDW+Sz3F3oMuZ1RvyR8BHcFy5ebif5caONoaAHfWDPI4zTHWSYJ4KnIyFk
 ZtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773708137; x=1774312937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yXEnpgFnvJvrdHFM9VkdJvHe7BEj/kxiGdjSYcigpbU=;
 b=DEpoOK2v7lwSHBPun8ctMLsGM37MGj2xwlEuQZlKZNFfMnz3VBehHtXxHFd09Fk5fI
 /NSI1SObAJgdNYCeycWjW/fjF+8yhzXu7qP7xXuatsQ0hSumYsmePVT/GVY9UTD4w4t3
 XL+2Nw94icBpi7fYdDnMqTHKLHAXq2v9bdCZfoZvxcHbThly2xtu13rMrwEHcIjeZn+d
 xjELVidgFpgcOw02lGcj/Bm8E/75QMP9TVkn2Nne2vXitVJgPwmgHvFd1Lnuftfxa+6x
 xPrnsS3DtQUqMcr6UUuaLGMe5w6XiVDG/IkPS5v4nCFlNd4vmbTVids5MkCrLr9hiUDa
 v1+g==
X-Gm-Message-State: AOJu0Yyt+ixWiaZd4opcCx27h/I/xWsY+pszaYKH7gvDXZpP5w9P0JKr
 aKVjZkmsCawcBS0DTPDsOtjBCM+cEnwTDZ2b//y7LBQIpl52zGnseWuc9vtandy93RQ=
X-Gm-Gg: ATEYQzxHSJ6MEXH6RRKZOL+L36j6C3AOnEdvUIws3KIJzCWdR4w6w47ikwVmuCZ3FCo
 Cy+RKtRLeXsZO3UXrumy2XtStjea3EjvNuKIcVPz/pr5MH5mLau/bJVk4fhe+emWIerHn8n7BZ7
 ecPKBOxWjMf5MHlVQYFGhwLaRmYzg3b4qMmpFb5vOeAEZfF03a4GEqzxewJOGiZQ1zj6wxbmSgP
 KNKxZBpGUNzC7m8qGyqQ+mokcrr4TxHbzGTNRLizgezb8NvfqYlrq5TvpZ6MSLk9SL9+F7RjtZU
 eWz/UntlqY9fDr8SW7m/1Jl/Uwlob5cmuS6MhF3NSbqx8Et5qxnmp2UCO7Lm4heDHxqgeiIR72S
 fxI1VN9ZBUuCD96o5d3U3TmzoDXw6OCa44+thz6WYsJ8EjlJv2B2oNYpAVb/VVyW8M/FYi2q3Md
 0hyS9fetPGPjxJV93tznQfvnpEt/KIbBzj5d9y/TLtyW9A0/RxA8PyO9cVqcj66JYR3I5e6YBUs
 XVwdfSeLw2xpmAnMPoG/FzOAiKB+3DZ
X-Received: by 2002:a17:903:2b0b:b0:2b0:64c4:34a0 with SMTP id
 d9443c01a7336-2b064c43b45mr9238095ad.10.1773708137318; 
 Mon, 16 Mar 2026 17:42:17 -0700 (PDT)
Received: from stephen-xps.local
 (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b04ccf9bf1sm70216385ad.24.2026.03.16.17.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 17:42:17 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:42:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v1 00/21] Building a better rte_flow parser
Message-ID: <20260316174214.5681e7d0@stephen-xps.local>
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
References: <cover.1773681363.git.anatoly.burakov@intel.com>
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

On Mon, 16 Mar 2026 17:27:28 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Most rte_flow parsers in DPDK suffer from huge implementation complexity =
because
> even though 99% of what people use rte_flow parsers for is parsing protoc=
ol
> graphs, no parser is written explicitly as a graph. This patchset attempt=
s to
> suggest a viable model to build rte_flow parsers as graphs, by offering a
> lightweight header only library to build rte_flow parsering graphs withou=
t too
> much boilerplate and complexity.
>=20
> Most of the patchset is about Intel drivers, but they are meant as
> reimplementations as well as examples for the rest of the community to as=
sess
> how to build parsers using this new infrastructure. I expect the first two
> patches will be of most interest to non-Intel reviewers, as they deal with
> building two reusable parser architecture pieces.
>=20
> The first piece is a new flow graph helper in ethdev. Its purpose is
> deliberately narrow: it targets the protocol-graph part of rte_flow patte=
rn
> parsing, where drivers walk packet headers and validate legal item sequen=
ces and
> parameters. That does not cover all possible rte_flow features, especiall=
y more
> exotic flow items, but it does cover a large and widely shared part of wh=
at
> existing drivers need to do. Or, to put it in other words, the only flow =
items
> this infrastructure *doesn't* cover is things that do not lend themselves=
 well
> to be parsed as a graph of protocol headers (e.g. conntrack items). Every=
thing
> else should be covered or cover-able.
>=20
> The second piece is a reusable flow engine framework for Intel Ethernet d=
rivers.
> This is kept Intel-local for now because I do not feel it is generic enou=
gh to
> be presented as an ethdev-wide engine model. Even so, the intent is to es=
tablish
> a cleaner parser architecture with a defined interaction model, explicit =
memory
> ownership rules, and engine definitions that do not block secondary-proce=
ss-safe
> usage. It is my hope that we could also promote something like this into =
ethdev
> proper and remove the necessity for drivers to build so much boilerplate =
around
> rte_flow parsing (and more often than not doing it in a way that is more =
complex
> than it needs to be).
>=20
> Most of the rest of the series is parser reimplementation, but that is ma=
inly
> the vehicle for demonstrating and validating those two pieces. ixgbe and =
i40e
> are wired into the new common parsing path, and their existing parsers are
> migrated incrementally to the graph-based model. Besides reducing ad hoc =
parser
> code, this also makes validation more explicit and more consistent with t=
he
> actual install path. In a few places that means invalid inputs that were
> previously ignored, deferred, or interpreted loosely are now rejected ear=
lier
> and more strictly, without any increase in code complexity (in fact, with=
 marked
> *decrease* of it!).
>=20
> Series depends on previously submitted patchsets:
>=20
> - IAVF global buffer fix [1]
> - Common attr parsing stuff [2]
>=20
> [1] https://patches.dpdk.org/project/dpdk/list/?series=3D37585&state=3D*
> [2] https://patches.dpdk.org/project/dpdk/list/?series=3D37663&state=3D*
>=20
> Anatoly Burakov (21):
>   ethdev: add flow graph API
>   net/intel/common: add flow engines infrastructure
>   net/intel/common: add utility functions
>   net/ixgbe: add support for common flow parsing
>   net/ixgbe: reimplement ethertype parser
>   net/ixgbe: reimplement syn parser
>   net/ixgbe: reimplement L2 tunnel parser
>   net/ixgbe: reimplement ntuple parser
>   net/ixgbe: reimplement security parser
>   net/ixgbe: reimplement FDIR parser
>   net/ixgbe: reimplement hash parser
>   net/i40e: add support for common flow parsing
>   net/i40e: reimplement ethertype parser
>   net/i40e: reimplement FDIR parser
>   net/i40e: reimplement tunnel QinQ parser
>   net/i40e: reimplement VXLAN parser
>   net/i40e: reimplement NVGRE parser
>   net/i40e: reimplement MPLS parser
>   net/i40e: reimplement gtp parser
>   net/i40e: reimplement L4 cloud parser
>   net/i40e: reimplement hash parser
>=20
>  drivers/net/intel/common/flow_engine.h        | 1003 ++++
>  drivers/net/intel/common/flow_util.h          |  165 +
>  drivers/net/intel/i40e/i40e_ethdev.c          |   56 +-
>  drivers/net/intel/i40e/i40e_ethdev.h          |   49 +-
>  drivers/net/intel/i40e/i40e_fdir.c            |   47 -
>  drivers/net/intel/i40e/i40e_flow.c            | 4092 +----------------
>  drivers/net/intel/i40e/i40e_flow.h            |   44 +
>  drivers/net/intel/i40e/i40e_flow_ethertype.c  |  258 ++
>  drivers/net/intel/i40e/i40e_flow_fdir.c       | 1806 ++++++++
>  drivers/net/intel/i40e/i40e_flow_hash.c       | 1289 ++++++
>  drivers/net/intel/i40e/i40e_flow_tunnel.c     | 1510 ++++++
>  drivers/net/intel/i40e/i40e_hash.c            |  980 +---
>  drivers/net/intel/i40e/i40e_hash.h            |    8 +-
>  drivers/net/intel/i40e/meson.build            |    4 +
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   40 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   13 +-
>  drivers/net/intel/ixgbe/ixgbe_fdir.c          |   13 +-
>  drivers/net/intel/ixgbe/ixgbe_flow.c          | 3130 +------------
>  drivers/net/intel/ixgbe/ixgbe_flow.h          |   38 +
>  .../net/intel/ixgbe/ixgbe_flow_ethertype.c    |  240 +
>  drivers/net/intel/ixgbe/ixgbe_flow_fdir.c     | 1510 ++++++
>  drivers/net/intel/ixgbe/ixgbe_flow_hash.c     |  182 +
>  drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c    |  228 +
>  drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c   |  483 ++
>  drivers/net/intel/ixgbe/ixgbe_flow_security.c |  297 ++
>  drivers/net/intel/ixgbe/ixgbe_flow_syn.c      |  280 ++
>  drivers/net/intel/ixgbe/meson.build           |    7 +
>  lib/ethdev/meson.build                        |    1 +
>  lib/ethdev/rte_flow_graph.h                   |  414 ++
>  29 files changed, 9867 insertions(+), 8320 deletions(-)
>  create mode 100644 drivers/net/intel/common/flow_engine.h
>  create mode 100644 drivers/net/intel/common/flow_util.h
>  create mode 100644 drivers/net/intel/i40e/i40e_flow.h
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_ethertype.c
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_fdir.c
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_hash.c
>  create mode 100644 drivers/net/intel/i40e/i40e_flow_tunnel.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow.h
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ethertype.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_hash.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_ntuple.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_security.c
>  create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_syn.c
>  create mode 100644 lib/ethdev/rte_flow_graph.h
>=20

I ran patch review with Claude and current AGENTS.md file. Found some bugs =
right away.

---
I'll start by reading the AGENTS.md from the project and then examine the u=
ploaded patch.This is a 21-patch series. Let me split it and read through e=
ach patch systematically.Let me start with the core API patch (01/21) which=
 is the most important one to review carefully.Now let me read patches 02 a=
nd 03 (infrastructure):Now let me quickly scan the driver implementation pa=
tches for correctness issues:This is a massive series. Let me focus on the =
key correctness issues rather than reading every line of every patch. Let m=
e check the most critical areas - the core API and the flow engine infrastr=
ucture for bugs.I found a key issue. Let me verify it:Good, I see the issue=
 I suspected. Now let me check the `__flow_graph_visit_node` call with `NUL=
L` item for the start node:Now let me check the `__flow_graph_visit_node` t=
o see what happens when `item` is NULL (called for START node):Now let me a=
lso look at the `ci_flow_engine_conf_reset` for the use-after-free I notice=
d:I see the use-after-free: `ci_flow_free(engine, flow)` then `TAILQ_REMOVE=
(&engine_conf->flows, flow, node)` - the flow is freed before being removed=
 from the list. Now let me check `ci_flow_create` for the same:I see anothe=
r issue: `ci_flow_create` never inserts the flow into `engine_conf->flows` =
TAILQ on success. The flow is allocated, parsed, installed, but never added=
 to the flow list. This means `ci_flow_destroy` and `ci_flow_flush` will ne=
ver find it.

Let me also check i40e patches quickly for any additional issues:Now let me=
 check the `__rte_internal` on `static inline` functions - that's unusual:N=
ow let me write up the review. I've identified several significant issues a=
cross this 21-patch series.

---

**Review of [RFC PATCH v1 00/21] Building a better rte_flow parser**

**Patch 01/21: ethdev: add flow graph API**

**Error: NULL pointer dereference in `__flow_graph_node_is_expected` when c=
alled from start node**

`rte_flow_graph_parse()` calls `__flow_graph_visit_node(cur_node, ctx, NULL=
, error)` for the START node. `__flow_graph_visit_node` passes this NULL `i=
tem` to `__flow_graph_node_is_expected()`, which unconditionally dereferenc=
es it (`item->spec`, `item->mask`, `item->last`) when `constraints !=3D RTE=
_FLOW_NODE_EXPECT_NONE`. If any start node has non-NONE constraints, this i=
s a NULL dereference. In practice the existing start nodes all use `EXPECT_=
NONE` so the early return saves it, but the API is fragile =E2=80=94 a sing=
le misconfigured graph will crash. Either guard with `if (item =3D=3D NULL)=
 return true;` before the dereferences, or document the contract that start=
 nodes must always be `EXPECT_NONE`.

**Error: Use-after-free in `ci_flow_engine_conf_reset` (patch 02/21)**

In the flow cleanup loop:
```c
RTE_TAILQ_FOREACH_SAFE(flow, &engine_conf->flows, node, tmp) {
    engine =3D ci_flow_engine_find(engine_list, flow->engine_type);
    ci_flow_free(engine, flow);       /* frees flow */
    TAILQ_REMOVE(&engine_conf->flows, flow, node);  /* accesses freed flow =
*/
}
```
`ci_flow_free()` frees `flow`, then `TAILQ_REMOVE` dereferences `flow->node=
`. The remove must come before the free.

**Error: Flow never added to TAILQ in `ci_flow_create` (patch 02/21)**

`ci_flow_create()` allocates, parses, and installs a flow, but never calls =
`TAILQ_INSERT_TAIL(&engine_conf->flows, flow, node)`. This means `ci_flow_d=
estroy` and `ci_flow_flush` will never find the flow (the `ci_flow_is_valid=
` TAILQ walk won't match), so flows are leaked on destroy/flush. The succes=
s path needs:
```c
if (ret =3D=3D 0) {
    flow->dev =3D engine_conf->dev;
    flow->engine_type =3D engine->type;
    TAILQ_INSERT_TAIL(&engine_conf->flows, flow, node);
    goto unlock;
}
```

**Warning: `__rte_internal` on `static inline` functions is a no-op (patch =
01/21)**

`__rte_internal` is a visibility/symbol-export annotation meaningful only f=
or non-static functions that appear in linker symbol maps. On `static inlin=
e` functions in a header, it does nothing. Either drop the annotation (sinc=
e these are header-only and already `static inline`), or if the intent is t=
o mark them as internal API, use a comment instead.

**Warning: `enum rte_flow_graph_node_expect` brace on wrong line (patch 01/=
21)**

The opening brace is on its own line (`enum ... \n{`). DPDK style places it=
 on the same line as `enum`.

**Patch 02/21: net/intel/common: add flow engines infrastructure**

**Warning: `ci_flow_alloc` erases only `struct ci_flow` base, not full allo=
cation**

When the custom allocator succeeds, the code does `*flow =3D (struct ci_flo=
w){0}` which only zeroes the base struct. The engine-specific fields beyond=
 `ci_flow` in the allocation are left with whatever the custom allocator re=
turned. If the custom allocator returns uninitialized memory (not zeroed), =
those engine-specific fields are garbage. The framework comment says "Custo=
m allocators only own their own engine-specific fields" but the intent seem=
s to be that the framework zeroes its own fields =E2=80=94 documenting this=
 more clearly or using `memset(flow, 0, sizeof(struct ci_flow))` explicitly=
 would be safer.

**Patch 03/21: net/intel/common: add utility functions**

**Warning: `ci_be24_to_cpu` uses `int` arithmetic on `uint8_t` shift**

`val[0] << 16` promotes `val[0]` to `int` (signed). If the compiler's `int`=
 is 16 bits (hypothetically), this would be undefined. In practice on all D=
PDK targets `int` is 32 bits so it's fine, but `(uint32_t)val[0] << 16` wou=
ld be more precise.

**Patch 12/21: net/i40e: add support for common flow parsing**

**Warning: i40e's `struct rte_flow` has both `struct ci_flow base` and `TAI=
LQ_ENTRY(rte_flow) node`**

The `ci_flow` base already contains a `TAILQ_ENTRY(ci_flow) node`. Having a=
 second TAILQ_ENTRY in the i40e `rte_flow` struct means there are two indep=
endent list linkages. The old code uses `flow->node` via the legacy path; t=
he new engine uses `flow->base.node` via `ci_flow`. This works during the t=
ransition but is confusing and wastes space. The legacy TAILQ_ENTRY should =
be removed once migration is complete.

**General observation across patches 04-21:**

The series progressively migrates each legacy flow parser to the new graph-=
based engine, which is a good incremental approach. The individual engine i=
mplementations (ethertype, syn, L2 tunnel, ntuple, security, FDIR, hash) ap=
pear to correctly translate the old hand-rolled parsing into graph nodes wi=
th validate/process callbacks. The graph definitions look structurally corr=
ect with proper edge termination sentinels.

The two critical bugs (use-after-free in reset, missing TAILQ insert in cre=
ate) and the NULL dereference risk in the graph parser should be fixed befo=
re this moves beyond RFC.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
