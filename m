Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EF5CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 18:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5596C4021F;
	Thu, 28 May 2026 20:29:23 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 95B7B4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 20:29:22 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-3045c195251so6891208eec.1
 for <dev@dpdk.org>; Thu, 28 May 2026 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779992962;
 x=1780597762; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeEJpzMMqkf/T/P8zsUoN6dsw0k+CkN5xU7KK0Q6Q5M=;
 b=esecnheDLB75S3x2c0C/Zd4KFwLd7u9IvVOXjJFn+aEeIOLautmEHcdn0Qm35K33vF
 CktI2s4NguHwqZsHCq6NLT03rFkeYXtssv3l1ibPQp7m2UuVSAVywFpb4epvBvuyqwn7
 x1Ps8wWiLXvO5UmU3/ebG69a9GzSyvaKrwiZ+8dPWNVXSUBL163rv5SgGWBXwLSKSjI4
 Tq18QPV9vhsjx0Co+6VHybmRopTZchqHA38YHnuf6OAIRtWo3ibQNfJBRu0Q2avClyOM
 ZQEE31m7ABaH5W606JYXUH2TQolUOWppqVjKvja8u/JJLkdAgCObWdV8TqDhuDnwT8c5
 iKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779992962; x=1780597762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yeEJpzMMqkf/T/P8zsUoN6dsw0k+CkN5xU7KK0Q6Q5M=;
 b=sAt6A7IAkX5yvsxGhNBVJeY5lIY61JQ2Ae6w2wc3dNBUaJwEiQzWdRK8Y3DZj4OMPe
 /fNX0YOJmrYLDVUze8TofOitXCWeThEnEE90F5pNI2CN9aIrjXHF0qT04I/+Z8D9v6Eu
 tXfgRDirmNvP/+wokQD4++4Q80yprx3lpkto9c9gdkny9azCMBHEV5fh5lQUMhi15YFH
 TlHBIRB54Ig/lvt61Z0SvwinrbBs8/Kupl79iaoPFFyl53Qutk3I3s/ffbGhNSe+pRn3
 6Vpwea3kuzUhCGqV47kvB8TiILyHgSbackf+Kl/W+9K691FL17E86htiv5CbF0/sxTZ1
 kEBA==
X-Gm-Message-State: AOJu0YxynnnoNg0MjSsHXOq1imiaENDico8oQ66xJvhMq29hGK9o1kKm
 lKHYWjh2Tx750Ey50vDiZkOWtgHs/pyIFcQPCszelNnmuCPBCrfUfs/B9YrLV3ETbeG8GQKOxTq
 /WDZ6
X-Gm-Gg: Acq92OEKeDE1CagwMDbN1O30DE4l9DpCF+amTEqibP52nDSsdIU0ZUTWMO2LaKN0wzO
 IT5HxVVW+W8JF6qWOt3TqGBjBCAELL9akal+18Eoc2PaXEn7ZzcBVyXQ+1D6J+UDUQv3RhLx114
 IJqmZGt0xA3jd5LasROA0dmfYGngDOEUb0QOHjo1GaYEEIJGerWULXQVI6g0rOWcp8v2Gd2KiPI
 x2LgAKubZJCgl3oecxcNspNPJdkOS78WUXCPjaVvazpkjV9a+z2Z8+oNhWPYZNPZG1i4fH4kkSH
 fUK8m5HbcTRQKYh8vjy89BTmpJaP+jZ1bFjo3cYxEw/wbCnHBQrxqWLtfJDf6b90/4AGQdGLsQ2
 2QhfO3zfByzIpVqqMEmJsoWJzdOBqGWLRxFDZFV/woaB19auZ6fuoggI1e2KxJl+qTe8xIEvUZV
 HIHeI7dAD2SLJBByCrg7Z44IaaNj9yikQW1HjFnGafNr9MTpGDdzV1YoBDcN1V/1FWwzoIOUqMU
 PU=
X-Received: by 2002:a05:7300:3708:b0:304:3c33:7ad6 with SMTP id
 5a478bee46e88-304e8f8cb8amr76473eec.11.1779992961450; 
 Thu, 28 May 2026 11:29:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e973c26esm19510eec.11.2026.05.28.11.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 11:29:21 -0700 (PDT)
Date: Thu, 28 May 2026 11:29:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: announce removal of flow director
Message-ID: <20260528112918.427a5e45@phoenix.local>
In-Reply-To: <ED4MTOXhQ4iCVj0Gg4IMwg@monjalon.net>
References: <20260528170059.155964-1-stephen@networkplumber.org>
 <ED4MTOXhQ4iCVj0Gg4IMwg@monjalon.net>
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

On Thu, 28 May 2026 20:19:15 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 28/05/2026 19:00, Stephen Hemminger:
> > There are still leftover bits in ethdev related to flow director (fdir).
> > Will be removing these in 26.11 so give final notice.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> > +* ethdev: The legacy filtering data structures in ``rte_eth_ctrl.h``,
> > +  including the flow director (FDIR) types (``rte_eth_fdir_*``, ``rte_fdir_*``)
> > +  and the ntuple/ethertype/SYN/tunnel/input-set filter types, are superseded
> > +  by the ``rte_flow`` API and will be removed in DPDK 26.11. The associated
> > +  driver-facing definitions in ``ethdev_driver.h`` (``RTE_ETH_FILTER_FDIR``,
> > +  ``struct rte_eth_fdir_conf``, ``enum rte_eth_fdir_pballoc_type``,
> > +  ``enum rte_fdir_status_mode``) will be removed at the same time.  
> 
> The problem is that some drivers rely on these structures for rte_flow.
> 
> Note: this file is big, please keep it sorted by moving this
> close to other ethdev and flow deprecations.

There are three cases of drivers using fdir:
 - simple ones which are just borrowing things like rte_filter_type
   addressing these is trivial; mostly just keep rte_filter_type for now
 - Intel ones like i40e and ixgbe which still expose fdir api's.
   Can deprecate the PMD API's and move the fdir structures into intel commonc code.
 - drivers where fdir was used in variable names but never really used the infrastructure.

Will have proposed patches in a few days.
