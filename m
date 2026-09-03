Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F02CC624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:05:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62D80427BA;
	Thu,  3 Sep 2026 16:05:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F08FF427BA
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:05:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788444338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wrLVnI7pqBB/LAwB257RsfPYKYSKoYNWeM5MeFkkmGI=;
 b=QGmN7ireHp010UTMoky1omBWh1m9TGqqDhxJADxNAJ+yhTu/Cv1NPSWV51SAkDdf4bnIRg
 oPomgszP2vf3Mf++Isb2I2GVIHopzxXXGIMgC7kmnKv0cbcSbzkATqoxoIDE41D5R4vKpk
 R2y+4pyhi0t63FJgYDSJTXd7W16fS58=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7--Hm35ceAMweStQ-bmC4wlw-1; Thu, 03 Sep 2026 10:05:37 -0400
X-MC-Unique: -Hm35ceAMweStQ-bmC4wlw-1
X-Mimecast-MFC-AGG-ID: -Hm35ceAMweStQ-bmC4wlw_1788444335
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a2073ff856so10855861fa.0
 for <dev@dpdk.org>; Thu, 03 Sep 2026 07:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788444335; x=1789049135;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wrLVnI7pqBB/LAwB257RsfPYKYSKoYNWeM5MeFkkmGI=;
 b=pE0IlIcHpwD03WEMQRvVizufuU7Pa4OsHKpmbcbQgX41lJQqo5dSgOWvzp8sCCqLgq
 siv2BNcMxcSArqxEkKD6xBlt3l3cJoyyOyvWk43aSHX7F84v0kxhmQCHOU8KNu7tzDlQ
 pPzuqFh265ZUO/VfsaEn7vIeURhZp3F2eC2Fa3V8aFx59S53tzjLN2nduOqVjoEFJcfd
 lsuPt7vSYtb6InVNkZq37k9T8Se2Mf2QCOuzgTzIsWyHJzm2kbqaBWvtW/fhM7nIkpDf
 5SD1RHC8o7vyuP66Ad9k0bxyyePDBoU/X4dGbmhFEzmm9Lxtj05j60IPmVgVGy2Srh9m
 /rfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5Wb63ajlDWd7w1JRv0cUBeNPF47z/KFX4+83IjD2dOaL/Q0Plrjfc3f8vJCRnH4+ncFE=@dpdk.org
X-Gm-Message-State: AFuF++leOgoVVhW+HCUJhIebW2EnPQOOiwB9sfgobD/6s7h9TnfG8lXx
 EFkfJ48gT0hXg+jMbXAgX13R2BJmOlir7w3Df5Q2RNMuo/6ta8pKcWES9TMdrMSqDDGfnLod/hE
 nlC8UNYR8Colpt1eUBpSR1ZPeCPbOVhBGAMDAR1q28rc7xgHLtWHtrWy3zudP9ffpNzoruhCbEn
 CgPkPx3rdtmbOgmeJhl8H6ghaT2D4Ogw==
X-Gm-Gg: AYBFou10PWNPXzn5f663PdIrLsNmXOBOjBvipV8JtQ8lq6ycNzJZh0pg61XhaN0ln03
 YpZbBRtvNHs2EppgWT3wknS/h70r3CvrEAp+h4+5hNOC+KsCUWejYFubWnFnX8jqMuC4LZNqP7/
 kOYS/CduQL5mnk23b7ikn20xfmTbakoPa2jxR68yqGaD8tEKnLpLSkDr/+C/TtNH6lRDd0STMsy
 2/RFpPLL/MczogIzXwI/oFy4K/j+vj/gGc8q3+mKsuzIaRn
X-Received: by 2002:a2e:be9d:0:b0:39b:3e32:4a58 with SMTP id
 38308e7fff4ca-3a34fd566damr26662631fa.10.1788444335435; 
 Thu, 03 Sep 2026 07:05:35 -0700 (PDT)
X-Received: by 2002:a2e:be9d:0:b0:39b:3e32:4a58 with SMTP id
 38308e7fff4ca-3a34fd566damr26662551fa.10.1788444334926; Thu, 03 Sep 2026
 07:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260903135353.3358303-8-prashant.gupta_3@nxp.com>
In-Reply-To: <20260903135353.3358303-8-prashant.gupta_3@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Sep 2026 16:05:22 +0200
X-Gm-Features: AcwNN1Wxzh2gt2gMi-IipASHnKinkn76u60RYWxKco6yT9saAwQNKKcIhN3JQfg
Message-ID: <CAJFAV8wo8kN59RivQz0_PaPHzDfdGrwLO5THfqPMFRnfVgEN6g@mail.gmail.com>
Subject: Re: [PATCH 07/45] drivers: fix double free of dpaa2 device on uninit
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, stable@dpdk.org, 
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: edtTGCw4LMME79kWJ2BeCYJJrxm7C51k_RGXvblYcl4_1788444335
X-Mimecast-Originator: redhat.com
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

On Thu, 3 Sept 2026 at 15:55, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
>
> From: Gagandeep Singh <g.singh@nxp.com>
>
> dpaa2_dpdmai_dev_uninit() was called from dpaa2_qdma_close(), but
> rte_dma close may run without a matching device remove, so the
> uninitialization (which frees the qdma_dev allocation and the MC portal)
> could run twice or leak the MC portal.
>
> Move dpaa2_dpdmai_dev_uninit() to dpaa2_qdma_remove(), which is the
> correct teardown counterpart of dpaa2_qdma_probe(). To reach the dmadev
> from the remove callback, store the rte_dma_dev pointer in
> struct rte_dpaa2_device at probe time and use it in remove, dropping the
> now-unused forward declaration.
>
> Fixes: 8caf8427f85a ("dma/dpaa2: introduce driver skeleton")
> Cc: stable@dpdk.org
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>

Nack.

I just cleaned this up so maybe it is probably a regression of my change.
868a3abd0ee5 ("dma/dpaa2: remove dmadev pointer from bus device")

Thank you.


-- 
David Marchand

