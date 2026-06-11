Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363C0CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:26:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 593224327C;
	Thu, 11 Jun 2026 17:26:42 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id A3B444278E
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:26:40 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-137dd523634so12769703c88.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781191600;
 x=1781796400; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xc/sz5DsbBoLR7bDJzQs3JfiOli+bPH8q2u5qlFqbHc=;
 b=KHHpFJseLq6WgV9R7Nmz9rpXDStv+NCt8MNeydEy9K8MWaUidIIpwGVBUkqLJlFjXI
 sWBXHU4j6S806wCNf19VgSTI109GsbOyEXma5SupHF4YIMv27MPD1kjjQSw9S7SS6jSh
 nwOpMTawA51tVGUmNUWjEcDgA4K4u3zPrj0A21lW0Lwy/WezAk+bax4STREBmdIYu6FS
 tp56xk037hIu4REUD0TlIynlK+nPew/dj8QPcVSnxOmOkg0jUQ17YTcUGCo89DuzdrWn
 lrr5kJcTn9Efoj8pbOKcX/Rb/TEAzt5jX0fWPFivlJsOQbwkHmYLD5FCE/nRQoQrM+1S
 Getg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781191600; x=1781796400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xc/sz5DsbBoLR7bDJzQs3JfiOli+bPH8q2u5qlFqbHc=;
 b=s1IJvbfJhclWqS1rXUZKcPKSfJ6ozlo4yAMQShPZ4P3J5Jz/wB+abqS4LDpW//qFXK
 Mqx/ICaqNHpMg52RmaLXybfsxIxhPLZN3TCKTuI6xlVi7dP/wKXkf0E0pMIIlzwj3l8Q
 WIUTVfHv9zHq+VTGs0nL96sA4yJNeSy6REEGyHw1jR0mlP0r95p1G+nIVFAZ+E4sUnyW
 xNtjM9x2A4fOwdIzM7GXOsH46vy4dJSToh9pDlriHh6YqhIl0xLUe3R5rfngqt0iiTQH
 zjuEeZpVu5ab7DhnFR4sMHf2P5iJG99lQzVzYpuVcI42iReFqQJ2AByBWwkRTypV1pXA
 p4MQ==
X-Gm-Message-State: AOJu0YyeSySKTOwybxaVjcXbmSkRnu9x94qL8rSOWS3puDKCcv3k/531
 ox4nJi6suToQEGU54hW1DIEF3Gz7DLE3pxlKI240mL99nrZY7d8k313nmD4BTjCs34U=
X-Gm-Gg: Acq92OEdppVQCx5xGFC9xeSzubKOpXEZtu1lFH1hP6DqXx3kJQcCfSudgp6R0/thXWb
 kkQBcYlaLpGQO/W/VNeXSwy5U2ddj6+uGnnrKdqm6JPuOQ8dXRvan+smCvQEL6HaJI3cPYXxvUV
 ooT/AYHNvXiDuj6Gj51lDdl1wUAI3b5JFdTzsxLxIYedVkoobY0vpSuijMozUmgECHOgGAj7v8O
 kUn9Lhoh8jFn904bbscJrhVzwHK9wDmhHcrVumP9MI0R0k6yfzwEOjPWxbai7sbDcwWteKlav1Z
 T5iJUBB5u3+QtEk74P4wX+di/Y8tXFRHal/nRnq7pbmJivNPcAeZtVr6B5WykWF3rKTcEcYBSaF
 vfOrh0HDlpf6oclCbrXx4ZoC34YAJNszN385MbZrVd0nnPe+oBGDo6puE5rHZWXSMvY35ABcBKm
 lC6Cf+Vr/dQtUEaK3qbxWhEOhYiNMyZzHmbFHYxyPg5IbQhO/AvLfHrmN42HLzzvZ1h40miztKX
 7U=
X-Received: by 2002:a05:701b:4552:20b0:138:44ab:75f7 with SMTP id
 a92af1059eb24-13844ab773cmr791725c88.21.1781191599570; 
 Thu, 11 Jun 2026 08:26:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-138430452a2sm2110508c88.14.2026.06.11.08.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:26:39 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:26:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>
Subject: Re: [PATCH v2 01/22] net/cnxk: update mbuf next field for multi
 segment
Message-ID: <20260611082634.46209b98@phoenix.local>
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
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

On Thu, 11 Jun 2026 19:50:08 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> As per the requirement of rte_mbuf_raw_reset_bulk(), the mbuf's
> 'next' and 'nb_segs' fields are required to be reset.
> This reset these field for multi-segment mbufs on cn9k platform.
> 
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>


Please put a cover letter on large multi-patch series in future.

The CI AI review doesn't look at original source and uses cost optimized
model (ie. is not that smart).  Did a UI based review and it saw:

Reviewed the v2 series. Three issues, rest look good.

[06/22] net/cnxk: reserve memory for lookup mem at probe

Error: error path returns success. At the new check rc is still 0 from
the prior successful roc_nix_dev_init(). When
cnxk_nix_fastpath_lookup_mem_get() returns NULL, "goto dev_fini" falls
through to "return rc" with rc == 0, so dev init reports success and the
rc=%d message prints 0. Set rc before the jump:

	if (!cnxk_nix_fastpath_lookup_mem_get()) {
		plt_err("Failed to reserve lookup memory");
		rc = -ENOMEM;
		goto dev_fini;
	}

[07/22] drivers: add support for devargs skip size

Warning: shared memzone freed while other ports still use it.
SKIP_SIZE_PKIND_MEMZONE is a single global memzone created once (lookup-
guarded) in roc_npc_init(), but roc_npc_fini() frees it unconditionally.
On a multi-port device the first port closed tears down the table the
other ports still read in roc_npc_skip_size_pkind_get() during inbound SA
creation; the lookup then returns NULL and skip-size pkind selection
silently stops working for the surviving ports. Refcount the memzone or
tie its lifetime to the common/inline layer instead of per-NPC fini.

[19/22] net/cnxk: add FEC get set and capability ops

Warning: feature not reflected in the features matrix. features.rst maps
the FEC feature to fec_get_capability/fec_get/fec_set, which this patch
implements, but doc/guides/nics/features/cnxk.ini is not updated with
"FEC = Y". The ops return NOTSUP on VF/SDP, so cnxk_vf.ini is correct as-
is. Add the matrix entry.

Note on [16/22]: the changes are good. Moving cpt_cq_ena inside the
"if (idev && idev->nix_inl_dev)" block fixes a NULL deref of inl_dev, and
cpt_cq_ena is initialized to 0 so the fall-through default is correct.
The roc_dev.c / roc_ree.c error-path rework fixes real leaks and wrong-
success returns.

Other patches reviewed with no issues.
