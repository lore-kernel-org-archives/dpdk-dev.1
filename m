Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA8AC982CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 00:19:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FF69400D5;
	Thu, 17 Sep 2026 02:19:50 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id B76024003C
 for <dev@dpdk.org>; Thu, 17 Sep 2026 02:19:49 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ed1368so3018355ad.1
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789604388;
 x=1790209188; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FkeHfzKRlmIkv9m/f1zEcNHcy4N+TcH8Z+mlRg3JH+A=;
 b=gxMepIynfJssk+v9o/xGOcmPX2NJiOIocifDIQw1d+WYXEEC3vd90OHArxY9unOGM9
 T1irS0i7LSDzCBPQ496Nx7yR3I7oKjJtbohRyPNGeY1hKV4j3WfhhxQNxaktP6jQImtv
 GeYsp+Rx+5O0B6EM4QrHPxw3Hz3FDjhfiUbNIl90slgcB0VnMXcMilWs/zaQxV1McaNu
 pzSP3Ui0oPeMDge3xouEiXoKy70UrJBtUA4s6G2nfP8no4t4TIj5QJX4UYN2OUqDZd1w
 rjzE37iZkG1dJVOQi//hNRAqyg4EZDQMsKundkqcHls4hSmSmmhYCy9BWg6sEu1+JH6Q
 LfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789604388; x=1790209188;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkeHfzKRlmIkv9m/f1zEcNHcy4N+TcH8Z+mlRg3JH+A=;
 b=XIg1kQ+D0+g6JRtEb5Xsq0vf/pf8NkBdEgAB8FeHIrQGc8YhtJXFwi3FuizfypvYiq
 4JEUcy58p92ViXKzqV9hgTmv0ajYgmVGU/kn8gtLNGV4XgBQWcyD8N0hROcyvRecRzMK
 DezkjY7Mrw4bXaqiNYFxWpxJLLCEY9+O8vq0M7nAnZdvzqYGcPT/LyPKTBWiIqQMjCR8
 orr207NVL1+l5v47eVAVzZ1OUEDtcuOPdR+mSSWbaZW4YvmLGrHwEeIwM8SJoW0j9VnI
 KkTFuodYEGJky5IPTzXHjUIHCedTeOBgMRYMror5rKGZhXhUgSkbbf+KBzZ5pjU6MN6m
 pYFg==
X-Gm-Message-State: AFuF++nrK4ZJGOmuRB5SYglFdbw+j6NO+s+ofHbh1e9RhY2uRMsmKI9B
 BTpj+3F4lfGa+2apbepChIXI1ik3OIakThESsifUAzVTSllZQIY1TIWNMpBrfFqQ87I=
X-Gm-Gg: AYBFou1u+YAnnu0z0tCFbfIQeYp0s7Diu2S6fbXmrRjU5C41rbDX1IzaflIqLLvBmce
 IAleHQq38kVp+Esqxa8pemp5Ez7zxAWJkUW+njiIV6AjPh4C4a3L3ogfRQfDBIrsnuV4b0FW7jy
 4S6p/CHv3dq6vweim74u8bEKjXnrxy66IEBi2qrfZcugz3QfAzDAqfH7mBXKI5tnd2WzOpSgYhc
 f3BObg8PsDQWS2Q2l7yGolQ0/sL1LveE2r6/Q+5UyLQsHkeM4w+IHvq9CpO+XQ+HKUxHh4bRsFi
 nU2SESWOz8Hp1IsxVel3iQTATK7o5kEUPF6FJRa4pQow7R3YM1/Vmz8T113ZgrCQYVII1TjCN5F
 fVbgqqHeR1tNvR39xBCi421BWG80tMkM9f4WeR4S9L3JFsrr0/X788gNoqFOtLY75Efu3bPQexw
 Q4KiXTlixVq/XZKKHeAf5aXGGqhTHoVgAq+QkMpoNknDgHy23kdT2gWdxnkrXvR61i4H2iYP6ZG
 9hAuib0CitXq25DDLQnwZukAlnu1+rDOyn4agR/
X-Received: by 2002:a17:902:f603:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2dd8dc0f6ffmr99830185ad.1.1789604388397; 
 Wed, 16 Sep 2026 17:19:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89eb896bsm17938665ad.43.2026.09.16.17.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 17:19:48 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:19:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/19] Building a better rte_flow parser
Message-ID: <20260916171942.502d6034@phoenix.local>
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
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

On Wed, 16 Sep 2026 13:18:06 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Most rte_flow parsers in DPDK suffer from huge implementation complexity because
> even though 99% of what people use rte_flow parsers for is parsing protocol
> graphs, no parser is written explicitly as a graph. This patchset attempts to
> suggest a viable model to build rte_flow parsers as graphs, by offering a
> lightweight header only library to build rte_flow parsering graphs without too
> much boilerplate and complexity.
> 
> Most of the patchset is about Intel drivers, but they are meant as
> reimplementations as well as examples for the rest of the community to assess
> how to build parsers using this new infrastructure. I expect the first two
> patches will be of most interest to non-Intel reviewers, as they deal with
> building two reusable parser architecture pieces.
> 
> The first piece is a new flow graph helper in ethdev. Its purpose is
> deliberately narrow: it targets the protocol-graph part of rte_flow pattern
> parsing, where drivers walk packet headers and validate legal item sequences and
> parameters. That does not cover all possible rte_flow features, especially more
> exotic flow items, but it does cover a large and widely shared part of what
> existing drivers need to do. Or, to put it in other words, the only flow items
> this infrastructure *doesn't* cover is things that do not lend themselves well
> to be parsed as a graph of protocol headers (e.g. conntrack items). Everything
> else should be covered or cover-able. In practice, just about all drivers will
> benefit from graph parsing as all but one of them implement only the protocol
> stack parts, which are the ones targeted by the graph helper.
> 
> The second piece is a reusable flow engine framework for Intel Ethernet drivers.
> This is kept Intel-local because I do not feel it is even appropriate to define
> such a framework for all drivers to use in the first place. Even so, the intent
> is to establish a cleaner parser architecture with a defined interaction model,
> explicit memory ownership rules, locking, initialization sequence,
> implementations of rte_flow API entry points, flow replay and memory cleanup,
> and engine definitions that do not block secondary-process-safe usage. It is my
> hope that this would serve as a model for other drivers to follow, expand on,
> rework, and improve, so that maybe down the line we *might* have a common
> rte_flow infrastructure for drivers to use.
> 
> Most of the rest of the series is parser reimplementation, but that is mainly
> the vehicle for demonstrating and validating those two pieces. ixgbe and i40e
> are wired into the new common parsing path, and their existing parsers are
> migrated incrementally to the graph-based model. Besides reducing ad hoc parser
> code, this also makes validation more explicit and more consistent. In a few
> places that means invalid inputs that were previously ignored, deferred, or
> interpreted loosely are now rejected earlier and more strictly, without any
> increase in code complexity (in fact, with marked *decrease* of it!).


AI review has lots of feedback (as always treat with skepticism)

Patch 1/19 (ethdev: add flow graph API)

Error

flow_graph.h breaks the build with -Dcheck_includes=true, in both the
C and C++ driver header checks:

  ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME_PTR,

rte_flow_conv() is experimental, and chkincs-drv builds without
ALLOW_EXPERIMENTAL_API:

  flow_graph.h:54:9: error: 'rte_flow_conv' is deprecated: Symbol is
  not yet part of stable ABI [-Werror=deprecated-declarations]

Either promote rte_flow_conv() to stable (it has been experimental
since 18.11), or do not call it from an installed inline helper.

Warning

The "non-END nodes must have edges" check never fires for the start
node:

  if (node->type != RTE_FLOW_ITEM_TYPE_END &&
          graph->edges[node_idx].next == NULL) {

The start node has no .type (per the doc and every graph in the
series), so its type is RTE_FLOW_ITEM_TYPE_END (0) and the check is
skipped. A graph with no edge list for START then dereferences NULL
here:

  next_nodes = graph->edges[cur_idx].next;
  for (edge_idx = 0; next_nodes[edge_idx] != FLOW_GRAPH_NODE_EDGE_END;

Test node_idx == FLOW_GRAPH_NODE_FIRST as well as the END type.

Info

FLOW_GRAPH_LOG declares
  extern int RTE_CONCAT(RTE_COMPONENT_NAME, _logtype_driver);
in an installed driver SDK header. Any driver that includes it but
registers its logtype under another name fails to link. Consider
taking the logtype from the caller or using RTE_LOG_DEFAULT_LOGTYPE.

Installed header exports unprefixed names (struct flow_graph,
flow_graph_parse, FLOW_GRAPH_*) and file-scope identifiers with a
leading underscore (_flow_graph_*), which are reserved.

struct flow_graph and struct flow_graph_edge use non-const pointers
(struct flow_graph_node *nodes, size_t *next), so driver node tables
holding function pointers cannot be placed in read-only data.

When _flow_graph_find_next_node() fails because the graph is
malformed, flow_graph_parse() overwrites that error with "Pattern item
not supported", which hides the real cause.

flow_graph.rst: "The the ``END`` node can also have callbacks".

Patch 2/19 (net/intel/common: add flow engines infrastructure)

Warning

The commit message and header claim secondary-process compatibility,
but the engine list pointer is stored in shared memory:

  const struct ci_flow_engine_list *engines;
  ...
  engine_conf->engines = engine_list;

ci_flow_engine_conf is embedded in dev_private (e.g.
  struct ci_flow_engine_conf flow_engine_conf;
in struct ixgbe_adapter), and engine_list is the address of driver
static data in the primary process. ci_flow_engine_ref_from_idx()
dereferences engine_conf->engines->engines[engine_idx], which is not
valid in a secondary process mapped at a different address. Pass the
engine list from the driver on each call, or resolve it per process,
instead of storing it in the conf.

Info

ci_flow_replay(), ci_flow_cleanup() and ci_flow_engine_conf_reset()
log error.message after a callback failure:

  CI_DRV_LOG(DEBUG, "engine '%s': failed to install flow: %s",
          engine_ref.engine->name, error.message);

error is zero-initialised, so a callback that returns non-zero
without calling rte_flow_error_set() passes NULL to %s.

ci_flow_flush() and ci_flow_cleanup() leave a flow on the list, and
leak it, when ci_flow_is_valid() fails:

  if (!ci_flow_is_valid(flow, engine_conf))
          continue;

ci_flow_flush() returns 0 after an uninstall failure while leaving the
caller's rte_flow_error populated.

Patch 3/19 (net/intel/common: add utility functions)

Info

Include guard comment does not match the guard:
  #endif /* _INTEL_COMMON_FLOW_UTIL_H_ */
guard is _COMMON_INTEL_FLOW_UTIL_H_.

Patch 5/19 (net/ixgbe: reimplement ethertype parser)

Warning

ixgbe_dev_stop() now turns off PTP timestamping:

  /* disable timestamping; the application must re-enable it after restart */
  if (adapter->filter.timesync_installed)
          ixgbe_timesync_disable(dev);

This is a user-visible behaviour change (timesync no longer survives
stop/start) with no release note in the patch.

Series

Patches 4-11 and 18 do not apply to main; the index lines reference
blobs not in the upstream history. Please state the base tree and any
dependent series (cover letter or base-commit).

Review-Result: ERROR
