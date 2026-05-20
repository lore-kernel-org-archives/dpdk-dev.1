Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3C0CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 00:32:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A78BC402DA;
	Wed, 20 May 2026 02:32:29 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 95C02402B0
 for <dev@dpdk.org>; Wed, 20 May 2026 02:32:28 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2f7ca62a3c4so4184447eec.0
 for <dev@dpdk.org>; Tue, 19 May 2026 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779237147;
 x=1779841947; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMBvdRBNOE/8EbmRwX4ZVOAJ3sO2e08gi0pHkvo61C8=;
 b=nRMuTdPOAKcnNBeotGDUQq9F+eWiZmf1Nca7liKuAZBkijBm5GWyQoK4vNCSEX0yPf
 ngZk4EMSaZFPN4SidjlYRXBEvSPE5+KtMkZd7tuESrCBNDfCiLBEtbAW86AKl30IK8xr
 fH3gGBCqNYBiyNBM9ezP/71sGGQ1x23hLaZXDamj/Yys/0F4zkbY+9exwdn+lV8su9j6
 r+ZYlg+4QMLQSlFO5DumtxDjKnEm4D9qVifyWziU31QUPPNYqgo6pSBvFrZr3HkkkzlZ
 iNl+HZOdBz9iSofuRaSzROPQadlC3XofVJ5NT1QuIpk+9GaDFyPgPDnG9up6zxD06rhI
 vQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779237147; x=1779841947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZMBvdRBNOE/8EbmRwX4ZVOAJ3sO2e08gi0pHkvo61C8=;
 b=stVvevXu76rdnnG9um3QNBS0evV0uUSfUPNuCUyKFlEqbtnR1JV3XaBALuB8hu740J
 LU10pl/coBy1LpguhapMB4k25QJWaSQfU27P8YAIYPoHt4CqE72GXqNJ1QGyO8M1CqVT
 eky11Jjgz1v9PvqIHBFdy04QnHL2SMk8Cs1JN4EHwgJ+yzgnUevpDpwvbxCm3LcW8OiX
 zgx0V79wjsX6kPHFR5qlkppM1uexkUqkoWrBd4RtrFTLlsYt4Qok1pda4qcOCxanBtGK
 ap242S1UYNolWvOeKvDwuy8EztaTR4DZRNnjU7A6dCGJf5UaZZ0RIgf4rkZpTY9KHgbR
 eWig==
X-Gm-Message-State: AOJu0YxLL95J4Otr3eW2ujSlcP+g2f5NHdgs0cXjh7tEoHQaEqmINJqB
 bq87ZidV/s9LFm/TnDx0F4L8bTnam8KBTRYTBQMn+3pesKS1Zw4xm+6fCABS0h0YNF8pp/No2H9
 lOplhGIs=
X-Gm-Gg: Acq92OGQlGnbsgP9Jbc+NQw3oF3A2g/R3Gkbd5soKgCMNIAwAEnk4VnptjKXXPanx6d
 qs9zb1PmrK6g+JijSs0OksQ3Gp/aXUZU4jYfZH+zezTmF3EDUH0m22Z7Odpxy9LEwK8KjFa8RoN
 usHzGQBUR0rb/8a8ryBrtoRwLqLuYRwAicfdMm77SF+7qCwmAIfBVRDY8BL5pqbObPsN+iwJQDS
 T3s1+DoIkYlYs0Gv9+kQpHnSdHCDYonoZkVP14Xag+sjwtzP3WhYwdFZSb8daaUwgKyeGN4aMfn
 sZbIK3GYb8Il0riwc3EcB8xL6+NV8edIUIxRmgFLD8V5ZPoLrKMCE1KI7/oGUc61oPGxY1QeWzi
 4mPyif6appMM5gEAF5s5RhGjbbGe6HX1GdLuArJBmF/CGaoJYsZvPFFHgNClfi6wYVXWnGqDiMS
 3bWsR9977KqKSonMPrMLH3MwP28OKP1fHr5KNu59mxqAwjdvl9yodfvF2jf629tfzkapxVb5iuI
 io=
X-Received: by 2002:a05:7301:3f0a:b0:2f5:3f62:37b4 with SMTP id
 5a478bee46e88-303982c04e9mr9877684eec.8.1779237147247; 
 Tue, 19 May 2026 17:32:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcc458sm21783346eec.18.2026.05.19.17.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 17:32:27 -0700 (PDT)
Date: Tue, 19 May 2026 17:32:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v18 00/11] net/sxe2: fix logic errors and address feedback
Message-ID: <20260519173224.430f53a6@phoenix.local>
In-Reply-To: <20260519144810.3951202-1-liujie5@linkdatatechnology.com>
References: <20260519030132.3780057-12-liujie5@linkdatatechnology.com>
 <20260519144810.3951202-1-liujie5@linkdatatechnology.com>
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

On Tue, 19 May 2026 22:47:59 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set addresses the feedback received on the v10 submission
> for the sxe2 PMD. The primary focus is on fixing vector path selection,
> ensuring memory safety during mbuf initialization, and cleaning up
> redundant logic in the configuration functions.

Great a couple more things to address before merge.

Review of [PATCH v18 00/11] sxe2 PMD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The v17 addendum issues are addressed in v18:

  - sxe2.ini features matrix now matches what the code advertises.
    VLAN offload, QinQ offload, Timestamp offload, Inner L3
    checksum, Inner L4 checksum, and FreeBSD rows are removed.
    All remaining "Y" / "P" rows correspond to entries in
    {rx,tx}_offload_capa or registered dev_ops callbacks.

  - sxe2_{rx,tx}_desciptor_status renamed to
    sxe2_{rx,tx}_descriptor_status throughout.

One new style issue and one general cleanup request:


Patch 09/11: drivers: add data path for Rx and Tx
-------------------------------------------------

Info: blank line added between function signature and opening
brace.  In the same hunk that renames the function:

  static int32_t sxe2_tx_descriptor_status(void *tx_queue, uint16_t offset)
  +
   {

There should be no blank line between the prototype line and
the body brace.  Looks like an editing artifact in this respin.


All patches: unnecessary (void) casts on void-returning calls
-------------------------------------------------------------

Warning: (void) casts on pthread_mutex_lock / pthread_mutex_unlock.

  (void)pthread_mutex_lock(&cdev->config.lock);
  ...
  (void)pthread_mutex_unlock(&cdev->config.lock);

These calls do return int, but in practice never fail when the
mutex is initialised with pthread_mutex_init(&m, NULL) =E2=80=94 the
documented errors (EINVAL, EAGAIN, EDEADLK) all require either
an uninitialised mutex (programmer bug) or non-default
attributes (recursive / error-checking, neither of which is in
use here).  The cast is redundant noise.  Just write:

  pthread_mutex_lock(&cdev->config.lock);
  ...
  pthread_mutex_unlock(&cdev->config.lock);

This is inconsistently applied even within the same file:
sxe2_common_dev_create_by_pci() uses a bare pthread_mutex_unlock()
two lines after a (void)-cast pthread_mutex_lock() on the same
mutex.  Pick one style =E2=80=94 bare calls =E2=80=94 and apply it everywhe=
re.

DPDK convention for void-returning callers is to call without
the (void) cast (see rte_spinlock_lock / rte_pktmbuf_free
usage across the tree).  The cast adds nothing and visually
clutters the lock/unlock pairs that are already busy enough.
Please drop all of them.

Series hygiene
--------------

The descriptor-status rename should be folded back into the
patch that introduces the function (patch 08), so the function
is correctly named at the commit it first appears.  Currently
patch 08 introduces sxe2_{rx,tx}_descriptor_status (good, fixed
from v17) but patch 09 still touches the function and its
hunks would have been cleaner if no rename was ever needed.  In
this case the fix landed in patch 08 already so it's fine =E2=80=94
just calling out the pattern.
