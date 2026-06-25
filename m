Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB281CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:46:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F72E402F0;
	Thu, 25 Jun 2026 18:46:00 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 345B4402BC
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:45:59 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137eb0d76beso559603c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782405958;
 x=1783010758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egY36vzUI1utmqQHhOoBO1zzWQm5fWBa3th/hW0PIJY=;
 b=YBSxHl+hXeybiG5i5OZ3+p36YMsTEPgq4e5q5EZ5bFTKur+tscrXyau+uv66azDFgo
 xNPvRXlshfS2RWrUJR7RdJh5ZsaNOF9pyf8L5ZSEnfIChaO9chdR+53TOu4A3KSuf/D1
 E6jlDljXCOR/bEBNtm2/BV0BpBffpI7oPHPbwdn6V35Me62m72L0DIq2lNn1g3Nkr+yF
 hR6bcxBCPZzFfV0QUr/ZpvlgBwBym+mFxC+IlsEVs8FMhe8mWeq4c/9H9bsitD2LU2xB
 1gDw4IglqDfcCz1ny3K/hpJibtLr+13TwOZEF+/aN71e2oDpE7GDVZuWC+zIgVdspgDc
 R3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782405958; x=1783010758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=egY36vzUI1utmqQHhOoBO1zzWQm5fWBa3th/hW0PIJY=;
 b=ibuWs7y1ZkiMI52NRV8/WY3ISZUkYhoRhesYpWrgsqm2yxdV06dA6vdmvLyQaA90Hu
 CTa/fSXPngi4DpXWYyeSFaZsmVr7V4unB4sjYCqi/iMmNfYrNJcwOwkdX/QG7zi7XE0P
 OmMf2OwbvJb/+xv9Zyf+V+0qOtOOTr0m8lolBAaJtZEUpeBwZ6VFpnu82FOAYmsGhvUt
 Y0JWiqUHkO036VpzRHb+stOejUlBeOn0mDjL9ZG3yqPCMkzFkKF7+28HWkwhaEqUnBfP
 tV9CLCi9amoUNAvURbY1DiN2Ph+HrNbLAHaM6Jx4EXJuoUC4tKtqfc6GzGbEjgYh38g7
 DNsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zFvgeiQc+A4g8avzIdW6lz1xMytav66z9MhYEMLuSeETVxCXKHzDoF8rPgV1Wwvnd0eQ=@dpdk.org
X-Gm-Message-State: AOJu0Yy7MhY23MPSlGYCsZ87nus65AVoIyQ7FshDYAKcDEVQC+8wiykm
 CV/mydZ4lJBc9vFBaAJJbsTLyHm1Pf41RiRzPKiAxgwopJVrv8PEuO9tXbM00rMwCSk=
X-Gm-Gg: AfdE7ckLjub0uiWisWfMRuKU7doaZq3lDUJIVvU1KPJBktv1m4p+LhNruYm/QLhlJzG
 d4AeXDFLiQIVPY6F6TL+1tbcDFCWk8VcwJqSyaliPLgVkGn9MFBeM/onWc6l/IxjlCmANJRahsp
 gyBw8jeIQHVgbxsSHd4oYeKreeFPSgrB6aYgTjxihoQxsBuojXXyf+hkbKDA6MTOYzPdm290mM6
 jtAspfRPk1S9DFChdCttUmMcKdPUjl2XyYSQoJUC1LPHrir+KRmWDC9IftGd/6mJ9DV20An8xcA
 Lsl7quc7T3OdwxQkVMtWblFhiAqiI5jeRO4Gpx+pMzmn+uj/oI5LDUTViRFVbS3Km2uaqecw1q6
 +wJD1wj/Nr1hlZkj465BoUcsbVaccZbseIaioMn9WStCWkE0BhmJgzNP667FegzaJAvCBUE4n1q
 fA8Ad5pfDVYnE0iRiSxlkfOIS5+4NG4abFaW5GmRD9yo6l6qHYFk36LaSwebGG/Ppy
X-Received: by 2002:a05:7022:61e:b0:138:59d:e1 with SMTP id
 a92af1059eb24-139c3d145c3mr10666710c88.24.1782405957865; 
 Thu, 25 Jun 2026 09:45:57 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm9908014c88.6.2026.06.25.09.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:45:57 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:45:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v3 00/18] net/dpaa: bug fixes for bus, net and fmlib
 drivers
Message-ID: <20260625094554.493702ab@phoenix.local>
In-Reply-To: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
References: <20260619060916.485258-1-hemant.agrawal@nxp.com>
 <20260619103901.2274740-1-hemant.agrawal@nxp.com>
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

On Fri, 19 Jun 2026 16:08:43 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series contains bug fixes for the DPAA PMD (bus/dpaa, net/dpaa,
> net/dpaa/fmlib and dma/dpaa).
> 
> v3 changes (AI code review feedback):
> - P05: Clarify commit message: p_dev == NULL is equivalent to h_scheme == NULL
>   since p_dev = (t_device *)h_scheme; consistent with all sibling functions
> - P16: Add comment explaining the intentional loop continuation; clarify
>   commit message about the loop design
> - P17: Add DPAA_DP_LOG(WARNING) before silent return on l3_len == 0 to
>   aid debugging of corrupt/uninitialized mbufs
> 
> v2 changes:
> - P05: Fix commit message API name
> - P08: Guard DPAA_PUSH_QUEUES_NUMBER env-var for LS1043A (errata)
> - P09: Document dpaa_finish() removal
> - P10: Fix wrong Fixes: tag
> - P11: Split into two patches with correct Fixes: tags
> - P13: Also fix rx_buf_diallocate -> rx_buf_deallocate
> 
> All patches are bug fixes tagged with Fixes: and Cc: stable@dpdk.org.
> 
> Gagandeep Singh (3):
>   bus/dpaa: fix device probe issue
>   net/dpaa: fix device remove
>   net/dpaa: fix invalid check on interrupt unregister
> 
> Hemant Agrawal (11):
>   bus/dpaa: fix error handling of qman_create_fq
>   bus/dpaa: fix fqid endianness
>   bus/dpaa: fix error handling in qman_query
>   net/dpaa: fix modify cgr to use index
>   bus/dpaa: fix fd leak for ccsr mmap
>   net/dpaa: fix xstat name for tx undersized counter
>   net/dpaa: fix xstat string typos in BMI stats table
>   net/dpaa: remove duplicate ptype entries
>   net/dpaa: fix wrong buffer in xstats get by id
>   net/dpaa: fix null l3_len check in checksum offload
>   net/dpaa: fix mbuf leak in SG fd creation
> 
> Jun Yang (1):
>   bus/dpaa: fix BMI RX stats register offset
> 
> Prashant Gupta (1):
>   net/dpaa/fmlib: add null check in scheme delete
> 
> Vanshika Shukla (2):
>   net/dpaa: fix port_handle leak in fm_prev_cleanup
>   dma/dpaa: fix out-of-bounds access in SG descriptor enqueue
> 
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  3 ++-
>  drivers/bus/dpaa/base/qbman/qman.c        | 11 ++++++---
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  6 ++---
>  drivers/bus/dpaa/dpaa_bus.c               | 17 ++++++-------
>  drivers/bus/dpaa/include/fman.h           |  6 ++---
>  drivers/dma/dpaa/dpaa_qdma.c              |  7 +++++-
>  drivers/net/dpaa/dpaa_ethdev.c            | 30 +++++++++++------------
>  drivers/net/dpaa/dpaa_flow.c              |  4 +++
>  drivers/net/dpaa/dpaa_rxtx.c              |  5 ++++
>  drivers/net/dpaa/fmlib/fm_lib.c           |  3 +++
>  10 files changed, 56 insertions(+), 36 deletions(-)
> 

Recent changes on main branch caused this patch series
to have merge conflicts in net-next. Since the conflict
was non-trivial related to hot plug; won't fix it myself.

Dropped it for now, please rebase and resubmit.
