Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B49C982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:20:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FB5B42D97;
	Mon, 21 Sep 2026 18:20:47 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 99BDE40298
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:20:46 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso2463928b3a.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790007646;
 x=1790612446; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JDxmuDPko6lcKlE+pr/O9B9KUIDtEY2/s2SQq8MVg2M=;
 b=EsOiEh/qThuhf7u2LIrwykSFTM7tyrnq2Mho7oj4qQfZDL8PQnko8TfP7nP0f0RMvi
 OIsgKPdgrPyAXrFVl/FaIcsjbnTPq/J+SmdmbvwVu4H2NylIeuznbzTR3MzhAqbPXxOM
 iUr9o2kl2y4Xi7vVYQu95DSma+t9J8TMShK4YPZsQEm6c5wyPrQEMQeusVtSxyAK6mXS
 yb04FP6r/ycwbGIA/Nc/EtBdO10VJRSUAYrQ18+ju+EHMUKNe5mjH6LVb2K5iwM8ngoE
 93jj0DRSZ0DH3Wq6VT2H48wYSPPzXy6jF/79IZz3P8hRI7+SF6F8MV20Q5poiZVnjFvy
 7cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790007646; x=1790612446;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JDxmuDPko6lcKlE+pr/O9B9KUIDtEY2/s2SQq8MVg2M=;
 b=uQSHjsObjO2hMuW6pl+bKKpiiP7W1AmIfBdwaDoGRi9q2lHfhcmRjvkZTHahVpyr22
 oKEJRgsvMLMMxb20hpJBXRUGQZ2rZJWD/NIBQtyZI6dmwPZqxLGAuhSeyeU/VwUNgXyD
 Tj6wM3iOi4SNA5BC305YrMCqPKoMQnhShNQnPFxmnGMtDVAf8VYwweupxGTuFq8jxsuv
 DdteWWhCDoop8xX0iQcq1ZvzWCd2cEG3yKe+O5/shx/sSeIZOhLAXQF85ZgH9efLrgGf
 q4nzhlrrqpr1mTVIe0SO5OJtj7ILdDRpHWwRyw/iqtZp+RbYCAuECOi10YyciyWdfu07
 jUVg==
X-Gm-Message-State: AFuF++kPbKHec4i3B51kxJt/WVsk1Q+AFAK+NzvJcItJpg3QsSb/RKX8
 uZaBLHI8GMu/ofkwdJ3X69e4689B+FuPG9rFqJQe/uPcPxzVXuVYYi4WcmBnCizNYYw=
X-Gm-Gg: AYBFou3EMVwUetnGqGGz1cHv4bQNVPPw8eo3QJQl+zdsgiJAGX9x2vlhX2WjFjiDK7O
 U8Yui+szSy6KZO8Cq7cOnvK1ngFeDmnhntP8dhtOuVXCZsc4d0GWEg9oY1p/eTU4IkuH0J0lIf+
 mZjZo1wrkmY9cQS3sMSIaFR9ChDDScsIxtPayb9W7YyGwp481b9iHK1dR4gQx69/5Ev0QHKou+5
 B3l34AvVCVtAsekEmrox/Ng9Nn3S20zNRKoupUV3wiVJNexg4Bo/OalIGy2zEB3RYQKynKwY1zM
 beZhCTHLXm/3dXGw1zKqXp2VU3SbyTgelmS0ZR3GdZUzPaU46KQ/lTZszqtx3HCy92/JcUzmdG4
 KpW5I7/C+cHDgQKPuB8bM0kqTb+BNyAtd0A7qdHISA2p0iohPqF4lvHD8ZLBeCJvcty3CjGHFFt
 bzSxU5W2cAtlxfMgklyCowTK4y6oEtYhVbD5DJvFxIj+coYu7e+EBz4MY93hBuCPzXGgbadsPMO
 TibXQ4MyjZxwjSzCO30Z4zvK9ystluqVURdkRaO
X-Received: by 2002:a05:6a00:2d9d:b0:878:34b8:2323 with SMTP id
 d2e1a72fcca58-87834b82569mr7857696b3a.43.1790007645618; 
 Mon, 21 Sep 2026 09:20:45 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877a94f4ab3sm3552827b3a.23.2026.09.21.09.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:20:45 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:20:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com
Subject: Re: [PATCH] net/bnxt: add support for driver mapping layer
Message-ID: <20260921092042.439df1aa@phoenix.local>
In-Reply-To: <20260921030932.1034887-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260921030932.1034887-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 21:09:32 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> 
> Add a driver mapping layer that abstracts HWRM send-message, FW
> status register mapping, and doorbell setup/write operations behind
> a per-mode operations table (struct bnxt_drv_api_ops), selected at
> runtime via a new bp->drv_map_ctx context. This lays the groundwork
> for supporting an additional driver backend alongside the current
> native mode, without disturbing existing native call sites.
> 
> Only the native backend is implemented here. Each abstracted
> operation keeps a fallback to calling its native implementation
> directly when bp->drv_map_ctx has not been initialized, so behavior
> is unchanged for any code path that doesn't go through
> bnxt_drv_init(). The higher-frequency doorbell ring/arm operations
> (bnxt_db_write/_epoch_write/_mpc_write/_nq/_nq_arm/_cq/_mpc_cq) stay
> static inline and call their native implementation directly rather
> than through the ops table, to avoid adding an indirect call to the
> per-packet doorbell path; only the control-path operations (HWRM
> send, FW status register mapping, doorbell setup) actually dispatch
> through bp->drv_map_ctx->ops.
> 
> Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

[PATCH] net/bnxt: add support for driver mapping layer

Error: this breaks multi-process. drv_map_ctx is rte_zmalloc()'d
and hung off bp, which is shared dev_private, and it stores
ops = &bnxt_drv_native_ops, a primary-process address.
bnxt_hwrm_send_message() dispatches through it whenever drv_map_ctx
is non-NULL, which is also true in a secondary. Any dev op issuing
HWRM from a secondary jumps through the primary's pointer, e.g.
stats_get -> bnxt_hwrm_ring_stats() from dpdk-proc-info. Function
pointers must not live in shared memory. Store only the mode and
select the ops table per process.

Warning: much of the code is dead. The bnxt_drv_db_* wrappers and
their ops slots are never called; the commit states doorbells stay
inline. mode and priv_data are unused, and the
BNXT_DRV_MAP_INVALID() failure paths are unreachable after init.
This is infrastructure with one backend and no consumer. Post it
with the backend that needs it, and add only the ops that backend
uses.
