Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE43CCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:52:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C50E5402DD;
	Mon,  5 Oct 2026 22:52:39 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 94CE5402DD
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:52:38 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so12930915ad.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791233557;
 x=1791838357; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b9BmOaPrrgi2X5zxFmyzt1binef0YJvsCFnWAF2cbQk=;
 b=uoVNXUWf8zAB2LZCK8aiovMHKbviXdOJAjXMe+YUHrPvdSv2tYtHBYN2Q8IJeOqvTw
 5j8ZIBM9fiti/N0kpNj81NKVqOe6TJ1Qb/VkFv9iatpQ1CxytodloFUxSQPxBssXibke
 7bEsJEDme+bIXOUbQEjilr3aL7/S9jinYaCt+s14YKxGSHMa1jGHKrBqF4pxMnl1yjov
 B7nfO0UyUu8nJFo0GhxbDVjvvxO/ks+2jZgZKot3z+kdM29KgU8VjZbHUmC+Jm9HAgUr
 Y81OWe8PiDNpXu/+moh9nTLfYvGP2Fb2lXvtSyOrda0EgXzxWMsqPYC37k+uyyMnemyr
 8fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791233557; x=1791838357;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b9BmOaPrrgi2X5zxFmyzt1binef0YJvsCFnWAF2cbQk=;
 b=KeIGC17YJ+4YFNH6JEBSHpQbCpxUkmX7QFhA3uIRpNQtjY+j/MUC90SS0950BiFpv9
 qeQXiMZM/tmRADUpWWTPwNhXVI/WlmODPlf6mx4LGOkf26970C6VHgGcq9w3Yr9zZxhc
 RLxGabknSw84tEgNttLO9zGrlt2YhmBaO57eV4vx3lY0WRc6aapTXVqmgcyNrk3Rgq9l
 WPvVEK04bWaYtLiV/k3faq9TloezmZjDliSyiP+40aMqQIhfWQ5+qHHcNcbODKI56KUK
 wGdnEnSq6HECqLmupslDKnpTgZUbpAoUK2gXusCHHy9c8e8KeONzeC8lsYo7EStbW/SG
 7ubg==
X-Gm-Message-State: AFq9FYJ/caYDXT1lIXhqOvGiICDfJvfNv0+x2hFWnkoE3+pEQrOBPqY9
 4MGo2x5PCpUO5y7bDEzD39GueyPrjeopXraCweyIpheH0SKkhg0onuU1n8e4iltSscI=
X-Gm-Gg: AYBFou1kBOYPLChAe58zSi5Z6QaCfMStivB4ohUYuQzqW2ZyZDD8EFXRlg5wkf902Yv
 gj7t7QwvWDkvEJLq1vWXcLZ9Z9UrkaLyFBUYDrEkQfC3diA+MskPfHC64caD3hPvjL4pi6Tzkgd
 fge/uRyf0v/TMLK1QTbt6hOs7FA/0UZCbWX98wCNjqz9WbUeSutFYB2n7MSapAkj/n+Njl2hQZS
 clqvzGiOKcGtgYmtu6O4AS/qu0uzdaRmitftRnhHnnUtu12g2ZOES9fQDWLC5lMnThUoLHjv/XS
 dhgEUml0PhdnMQ+JEbzqLwVtMWt7Eiv9yJYIJ1S7aXg308709jTNc4h7prNInRpq+7t24Hh+J2O
 gLFqGC7qDsr/svQRdIETcKzo+7xp9T6ZvOOPm4e6GfijW897lzQGVVAemLUw4EIVd2PzUlm19m/
 5UI2WyZnCfHQhOsEg/ySwViaRI6XAlLhcVaJfQqDAXMhhSRyG1OCTF6awY9sc84vqt8SsCPkH6r
 VmQGpHNgRLCoFMuuhjQ8o4Hp3iigQiTDa6DbgG/
X-Received: by 2002:a17:90a:1c89:b0:39d:f6a6:60d8 with SMTP id
 98e67ed59e1d1-3a6cf903622mr7386269a91.3.1791233557454; 
 Mon, 05 Oct 2026 13:52:37 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853cce4dbsm575180a91.4.2026.10.05.13.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:52:37 -0700 (PDT)
Date: Mon, 5 Oct 2026 13:52:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Manish Kurup <manish.kurup@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Farah Smith
 <farah.smith@broadcom.com>, stable@dpdk.org
Subject: Re: [PATCH v2] net/bnxt: fix global table scope shutdown order
Message-ID: <20261005135234.52cc547a@phoenix.local>
In-Reply-To: <20261004142037.1583073-1-manish.kurup@broadcom.com>
References: <20261001174039.1155386-1-manish.kurup@broadcom.com>
 <20261004142037.1583073-1-manish.kurup@broadcom.com>
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

On Sun,  4 Oct 2026 09:20:37 -0500
Manish Kurup <manish.kurup@broadcom.com> wrote:

> From: Farah Smith <farah.smith@broadcom.com>
> 
> Track per-port table-scope teardown state (scope type and, for GLOBAL
> scope, a shared FID reference count) and clean up in the correct
> order on bnxt_en/DPDK shutdown.
> 
> Previously, unloading the L2 kernel driver with DPDK shutdown could
> crash because table-scope resources were torn down without properly
> tracking which FID was the last user of a GLOBAL scope. Fix this by
> introducing glb_tbl_scope_fid_cnt bookkeeping and freeing the per-port
> CPM before removing the FID from the scope, and only fully retiring
> shared GLOBAL-scope memory once the reference count reaches zero.
> 
> The teardown order was initially fid_rem -> mem_free, but that
> sequence was found to trigger PXP errors: fid_rem disables the scope
> in firmware, so any subsequent mem_free on that scope is operating on
> an already-disabled scope. Reordered to cpm_free -> fid_rem -> mem_free
> so the scope is only disabled and its memory released after this
> port's CPM is torn down. The relative order of fid_rem and mem_free
> is unchanged from before; the new step is cpm_free running first.
> 
> Fixes: 23e0dc62d19e ("net/bnxt/tf_core: add global table scope")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Farah Smith <farah.smith@broadcom.com>
> Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
> ---

AI finds lots of issues here.
My gut feeling is you are using AI and not looking enough at the underlying
design and architecture problem. AI will build a house of cards if you ask it
and it will not tell you what you are trying to do is wrong.

You need to rethink the ownership model.


[PATCH v2] net/bnxt: fix global table scope shutdown order
patchwork 170526

Errors
------

1. flow_db_lock used outside its lifetime

ulp_tfc_tbl_scope_deinit() now takes the fdb lock:

	if (bnxt_ulp_cntxt_acquire_fdb_lock(bp->ulp_ctx)) {

but ulp_tfc_deinit(), which runs for the last port in a session,
destroys that mutex just before calling it:

	pthread_mutex_destroy(&bp->ulp_ctx->cfg_data->flow_db_lock);

	ulp_tfc_tbl_scope_deinit(bp);

Locking a destroyed mutex is undefined. On glibc it fails with
EINVAL, so the last port always takes the "conservative" branch and
mem_free() is called with fid_cnt 1. The last user of the GLOBAL
scope, the case this patch is for, never retires it. Before the
patch that port passed the firmware count from fid_rem.

Init has the mirror problem. ulp_tfc_init() calls
ulp_tfc_tbl_scope_init() before

	rte_thread_mutex_init_shared(&bp->ulp_ctx->cfg_data->flow_db_lock);

so the first port locks a mutex that has not been initialized. It
works only because zeroed rte_zmalloc() memory matches the default
initializer on glibc.

Call ulp_tfc_tbl_scope_deinit() before pthread_mutex_destroy() in
ulp_tfc_deinit(), and initialize flow_db_lock before
ulp_tfc_tbl_scope_init() in ulp_tfc_init().

2. Reference taken per port, tracked per session

tbl_scope_type and glb_tbl_scope_fid_cnt are added to struct
bnxt_ulp_data, i.e. cfg_data, shared by every port in the session.
Deinit drops a reference based on the shared type, not on whether
this port took one:

	} else if (scope_type == CFA_SCOPE_TYPE_GLOBAL) {
		rc = bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_dec(bp->ulp_ctx);

ulp_tfc_ctx_attach() does ref_cnt++ before ulp_tfc_tbl_scope_init().
If a second port fails after bnxt_ulp_cntxt_tsid_set() (config state
timeout, mem_alloc, cpm_alloc), bnxt_ulp_port_deinit() sends it
through ulp_ctx_detach() to ulp_tfc_tbl_scope_deinit(). It sees the
GLOBAL type set by the first port and decrements the first port's
reference to 0. mem_free() then gets fid_cnt 0 and, on a VF, resets
the global tsid state while the first port is still using it.

Keep the per-port state in struct bnxt_ulp_context next to tsid,
e.g. a flag set when this port incremented the count, and decrement
only when it is set. The commit message already calls this per-port
state.

Warnings
--------

3. Counter scope does not match the state it protects

The GLOBAL tsid state that mem_free() resets is tfc_global in
tf_core/v3/tfo.c, one per process. The new count is in cfg_data, one
per session, and ulp_get_session() keys sessions on PCI domain and
bus unless BNXT_FLAGS2_MULTIROOT_EN is set. Two ports on different
buses using the global scope each run their own count to 0, and the
first to close resets state the other still uses.

The patch also discards the firmware count:

	rc = tfc_tbl_scope_fid_rem(tfcp, fid, tsid, NULL);

The HSI defines fid_rem's fid_cnt as the FIDs remaining in the scope.
The commit message needs to say why a driver-side count replaces it,
and the count needs to live at the same scope as tfc_global.

4. v2 rollback is not needed and is wrong

The rollback is reached only if bnxt_ulp_cntxt_acquire_fdb_lock() or
bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_inc() fails. Once the lock is
held, ulp_ctx and cfg_data are non-NULL, so the increment cannot
fail. If it is reached:

- v1 did not leak the CPM. Both callers of ulp_tfc_tbl_scope_init()
  fall into an error path that runs ulp_tfc_tbl_scope_deinit() with
  tsid still set, so with the rollback cpm_free, fid_rem and mem_free
  run twice.

- mem_free(..., 0) tells tf_core this is the last FID. The comment
  "only FID in scope (glb_tbl_scope_fid_cnt_inc never ran)" does not
  follow: this port not incrementing says nothing about ports already
  attached (first == false).

- The order is cpm_free, mem_free, fid_rem, not the order deinit and
  the commit message say is required.

- return -1 discards rc.

Drop the rollback and return rc as v1 did.

5. Commit message and comments do not match the change

The third paragraph says fid_rem -> mem_free causes PXP errors
because fid_rem disables the scope, then gives cpm_free -> fid_rem ->
mem_free as the fix, which still has fid_rem -> mem_free. What moved
is cpm_free ahead of fid_rem; say why cpm_free must run before
firmware deconfigures the scope.

On a PF, tfc_tbl_scope_mem_free() ignores fid_cnt and uses the TPM
pool count, so for PFs the reorder is the whole fix. The count only
matters on the VF GLOBAL path; say so.

The comments are off the same way:

	/* Free this port's CPM before mem_free; mem_free invalidates tsid scope state */

	/* Still attempt mem_free and fid_rem to avoid FW/driver state divergence. */

The first names the wrong ordering constraint. The second sits after
fid_rem has already run.

Info
----

6. Six non-static accessors are added for two fields used only in
bnxt_ulp_tfc.c, and bnxt_ulp_cntxt_glb_tbl_scope_fid_cnt_set() has no
caller. Every call is made with the fdb lock held, so the NULL checks
cannot fire; they only create the unreachable failure branches in
init and deinit. Access the fields directly under the lock, or make
the helpers static.

7. In ulp_tfc_tbl_scope_deinit() every "goto cleanup" is taken with
have_scope false, so the label and flag are a plain return. scope_rc
and the "our_fid_cnt = 0" branch are also redundant.

Review-Result: ERROR
