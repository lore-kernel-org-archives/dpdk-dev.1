Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C99FC982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 00:26:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B21D400D5;
	Thu, 17 Sep 2026 02:26:50 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 468B94003C
 for <dev@dpdk.org>; Thu, 17 Sep 2026 02:26:49 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso249715a91.1
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789604808;
 x=1790209608; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EWSj4ITuSviVz5KN3S8Vfp2aYCUScmNng9Nxbhp9jlY=;
 b=QAISRhR3qWdLAp6nLlvy+PAD1yXcBgG7arihPb7FsoakTwoQHV71uHPBM/ZaSHQLDS
 BI2n0PZ3caA0GmoRN7/dZ3FZ2GwF3DLTW/dnCbfvL/Xy9XFnDk52KTBoUnA1d/Kf1UPx
 JFCMnQPpnjyyDlmBy3nMB5R5j65GRFQxClIfq+7oEyGomFG9VpGjD0NeWr/MKsXdXhRa
 Sef5AyxcXMuPExqoiuI81eLTfPeEkelyiutJS1aPWdLlngKmlmKd5mYFjlYxVLCPxloF
 CQU+O+MJS7ICsk3B2vSeTScqZ0ndf/FjMPJAuNtkBLPoCrwMx7QBDlYlJBcAAUFKso+E
 jNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789604808; x=1790209608;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EWSj4ITuSviVz5KN3S8Vfp2aYCUScmNng9Nxbhp9jlY=;
 b=v3bf6UVKm9KCDqFEJkbBbAzYsUxEzb98YXM6UJ8m4hYkl6/Al2vofIfo1l7+rn/fOH
 +WaBtGrGnAv0iaCMYXe+N94SSPU5OX59V9JqrQCHKM0FZ4DJgYGjKM9Svp70RPFQARw9
 REqJZ1VZVfJcTD/wY/E6JBgFNIZ7sw1yxsJ6t4LFAy3l5+Wypgw0MI4g9xoLJZSJ8EIO
 S1qi5wLiOAaHgh8eXtFTG13LS/HPqE1D8O7nD0Pxd4iWOwp1NZdOfyKNITPFArB5ZdqL
 AkYJp1z5yfeaPuxNRhlutZpiScAd2a4Yn1vgGX5jDTk/xkKnJiYJ0d5zNZrt/FpjIn8g
 XfNQ==
X-Gm-Message-State: AFuF++mULYs00TDU3sMm9R+xlUYWyTC6zUJb6h1o5CKEE87FNFNW+IH8
 ck63SV2u3yf1L+4ZWi/n4xTTTIiPFf8y77P0jZwNQNPqTK869LBY0kr4bUwqVqOM310=
X-Gm-Gg: AYBFou0R7PNxw9sZO4GtPwfK3Ly6By1bN4ewBsIBNmsNfVRfuby9uEcWZOkf/sKOUJA
 XR2UqStA7zbClfLHxS6SeC7rACG8R5JWbW+FLvTmni2UjfE35c1DFDp1bGc+HeyRSkBjgUIIB5A
 QThwJfIf6/3o99o7UKlN9q7po6d4ZNBvoYo/PVYMNAKUhlAaJe7ZuCeFCPGhQ+r7uj9f6qKWaYA
 xRw5/u7m4KPYeqyMo8QTohQu+k0Ms1HoZycObc8NzTPVy3c0UTaT2k1+h0HlRfl5XNALJaW7RE+
 eJEpbBhifSg79VAR4MpaZnf2zQDpbIIzPebieGKDaEKuBxDWyCS/FmTqNhSRpwtyQO27/rOwNBL
 tCTUXYqYB5jzK90AQ93UflivjlBthKogYqfee0PC+PCQuvnRYjeeCoqn70dTGARHguS0Mw0vkrv
 rg2GMjKp8oGEe3tsBsXSi2lOAc+ACFC2Q82coGgF29ZRiRAo7cArHRlNBiHKmZbZzTb288R7L0+
 O0POX26Z5OaOE6tsQGKOkzXSsvxco56+gOiYLHC
X-Received: by 2002:a17:90b:5785:b0:39d:ee20:1e2c with SMTP id
 98e67ed59e1d1-39e1e5042famr14273488a91.18.1789604808114; 
 Wed, 16 Sep 2026 17:26:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35b6a350sm2000184a91.0.2026.09.16.17.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 17:26:47 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:26:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 02/19] net/intel/common: add flow engines infrastructure
Message-ID: <20260916172640.2dabe913@phoenix.local>
In-Reply-To: <63c3a0cb245f38af6da4d14547aaac9a4789c850.1789560944.git.anatoly.burakov@intel.com>
References: <cover.1789560943.git.anatoly.burakov@intel.com>
 <63c3a0cb245f38af6da4d14547aaac9a4789c850.1789560944.git.anatoly.burakov@intel.com>
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

On Wed, 16 Sep 2026 13:18:08 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> +
> +/*
> + * This is a common header for Intel Ethernet drivers' flow engine
> + * implementations. It defines the interfaces and data structures required to
> + * implement flow rule engines that can be plugged into the drivers' flow
> + * handling logic.
> + *
> + * Design considerations:
> + *
> + * 1. Ease of implementation
> + *
> + * The flow engine interface is designed to be as simple as possible with
> + * obvious defaults (i.e. not specifying something leads to behavior that
> + * would've been the most expected in context). The point is not to produce a
> + * monstrous driver-within-a-driver framework, but rather to make engine
> + * definitions follow semantic expectations of what the engine actually does.
> + *
> + * All the boilerplate (flow management, engine enablement tracking, etc.) is
> + * handled by the common flow infrastructure, so the engine implementation only
> + * needs to focus on the actual logic of parsing and installing/uninstalling
> + * flow rules, and defining each step of the process as it pertains to each flow
> + * engine.
> + *
> + * It is expected that drivers will use other utility functions from the common
> + * flow-related code where applicable (e.g. flow_util.h, flow_check.h, etc.).
> + *
> + * 2. Full secondary process compatibility
> + *
> + * In order to support rte_flow operations in secondary processes, we need to
> + * store which engines are enabled for particular driver instance, and resolve
> + * them at runtime. The engine index (its position in the engine list) is used as
> + * a bit position in a driver-specific 64-bit field of enabled engines. This
> + * way, the engine definitions can be stored in read-only memory, and referenced
> + * by both primary and secondary processes without issues.
> + *
> + * For this to remain safe, flow engine lists and engine definitions must be
> + * immutable for process lifetime (declare them as const).
> + *
> + * Note that this does not imply that all drivers are therefore able to support
> + * rte_flow-related operations in secondary processes - that is still up to each
> + * driver to implement. This just ensures that the flow engine framework does
> + * not prevent it.
> + *
> + * Engine callbacks must not access or retain an `struct rte_eth_dev *` pointer,
> + * as that object is process-local; use the process-independent
> + * `struct rte_eth_dev_data *` provided by the framework instead.
> + *
> + * The per-instance engine configuration is set up and torn down exclusively by
> + * `ci_flow_engine_conf_init()` and `ci_flow_engine_conf_reset()`. These functions
> + * should only be called at device setup/teardown by primary process.
> + *
> + * 3. Flow object lifecycle is framework-owned
> + *
> + * Engines are expected to treat framework-provided context and flow objects as
> + * storage they fill in, not storage they own. In other words, engine logic
> + * should focus on contents of flow data, while object lifetime is managed by
> + * the framework. Engines may still allocate auxiliary data, but only in places
> + * where the framework guarantees a matching teardown call, which will give the
> + * engine the opportunity to release said auxiliary data.
> + *
> + * 4. Pattern parsing: flow_graph and pattern_parse callback
> + *
> + * The flow engine framework is designed to work hand-in-hand with the
> + * `flow_graph` parsing infrastructure. Each engine may provide a pattern
> + * graph that is used to match the flow pattern, and extract relevant data
> + * into the engine context provided by the framework.
> + *
> + * Engines may also provide a `pattern_parse` callback that is invoked before
> + * the graph parser runs. This allows engines to handle pattern items that
> + * don't fit neatly into the graph model (e.g. FUZZY items that can appear at
> + * any position), as well as ignoring the graph parser entirely and implementing
> + * custom pattern parsing.
> + *
> + * There is no way to completely ignore pattern contents for the engine except
> + * for defining a noop `pattern_parse` callback. This is by design, as such case
> + * is considered rte_flow API misuse. By default, even for empty fallback case,
> + * a meaningful pattern (one that is not empty or ANY) will be treated as error.
> + *
> + * 5. Setup, teardown, and flow list lifecycle ordering
> + *
> + * `ci_flow_engine_conf_init()` and `ci_flow_engine_conf_reset()` are
> + * primary-process-only (see point 2), and the framework does not serialize
> + * them against concurrent flow operations or against each other - the driver
> + * must do so.
> + *
> + * The expected sequence of calls for a driver instance is:
> + *
> + * - `ci_flow_engine_conf_init()` should run from the driver's `dev_init` path.
> + *
> + * - At `dev_close`, `ci_flow_cleanup()` should be run first to drop all flows
> + *   and their internal tracking. Then, `ci_flow_engine_conf_reset()` can be run.
> + *
> + * - Devices may or may not advertise `RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`,
> + *   i.e. support for keeping flow rules across a `dev_stop`/`dev_start`
> + *   cycle.
> + *
> + * - If the device does not advertise this capability, flows must be
> + *   flushed via `ci_flow_flush()` as the first step of `dev_stop()` (doing so
> + *   later may interfere with flow uninstall).
> + *
> + * - If rule replay is needed (i.e. flows were kept rather than flushed at
> + *   `dev_stop`), the driver should call `ci_flow_replay()` from `dev_start`
> + *   to re-install the kept flows to hardware as last step.
> + *

This is excess commenting, which is the kind of thing AI likes to generate
unless you tell to get to the point. Even AI evaluating itself said:

Warning

Comments are far longer than the code needs. Roughly a third of
flow_engine.h (587 of 1620 lines) and flow_graph.h (175 of 507) is
comment text, and many comments narrate the obvious or restate the
design document. Examples:

flow_graph.h, _flow_graph_node_is_expected():

  /*
   * In the interest of everyone debugging flow parsing code, we should
   * provide the user with meaningful messages about exactly what failed,
   * as no one likes non-descript "node constraints not met" errors with
   * no clear indication of where this is even coming from. What follows
   * is us building said meaningful error messages. It's a bit ugly, but
   * it is for the greater good.
   */

flow_engine.h: the file header and the struct ci_flow_engine_ops
comment together run about 290 lines of design essay. ci_flow_parse()
repeats the same match-mode table that already appears above
ci_flow_engine_ops.

ixgbe_flow_dev_dump() and i40e_flow_dev_dump() (patches 4 and 13)
carry a 13-line comment explaining one if statement.

i40e_fdir_flow_install() and i40e_fdir_flow_register() (patch 16)
open with paragraph-length comments before a single condition.

Short one-line comments are enough for straightforward code. Put the
design description in flow_graph.rst (or a short block at the top of
flow_engine.h) once, and drop the per-function restatements. Trivial
comments such as "/* success */", "/* is the pointer valid? */" and
"/* engine looks valid */" can go.
