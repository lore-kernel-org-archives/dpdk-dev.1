Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34483EFB7F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F0C84027F;
	Tue, 24 Feb 2026 08:59:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DCFAF400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771919941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ra8xCD5TJAmAkwkpoUNryfCnH3YAH/ZIiym/A5HOVM=;
 b=LnCjq9zW1CBIBzWjVsakNTrpMiTvdN/DB63WYAuHFUM/sk4n1P8PxD5GBuB1JceN7bM4XU
 7TXkgAJqdJsStXM5D7S8wbwq2V6tLJlnejIutLk8GKk35alxgCLQSlSMjmuk10AqjupdoS
 qmX/eFKD5h28j0jllxu+ASIXU/U2b8o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-nLqMxzECPD68t0dxAkFcPA-1; Tue, 24 Feb 2026 02:59:00 -0500
X-MC-Unique: nLqMxzECPD68t0dxAkFcPA-1
X-Mimecast-MFC-AGG-ID: nLqMxzECPD68t0dxAkFcPA_1771919938
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-386fe2386easo32370151fa.0
 for <dev@dpdk.org>; Mon, 23 Feb 2026 23:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771919938; x=1772524738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ra8xCD5TJAmAkwkpoUNryfCnH3YAH/ZIiym/A5HOVM=;
 b=Ry6UbIo4KWfircPbUe02DW+gUYJiyi8i855GO0L+Ibrmi+1D7Us2PsMocqJsTWzlnX
 RhXxIlX687IKwf9YXrI3+xMWfMz7DOrmexC9ZbDmPXazrSwE3uMOSnI8i9IGMO4NkGud
 +n+Vng36e6PGaOK+eRpfL4KD1rcuwbuYnGKTTPiv1jF7msY1oD0Zk1iZ2if9Lq8CSeFS
 Ru0/aR+0Ayd/FHSgkI4Yp9wEURYQCSxrl6NV2UJ+ijircBCmFccAoV68b5l9IEr5XTm4
 QIQEW7ej3OVF7Ia04TGPupVETBBbtkrTKXUJ4sZWOQSoT9T5QmlhQd4Gx00rlVEsTr/K
 sqvQ==
X-Gm-Message-State: AOJu0YyDwNokDTdpxVq69Pedy57jOc4tGQ/THFh77Z8UwIMSNM1U336E
 eJsU6654MPCLzkAOVdyhehT8V8xIVXfXv7Mn39rtKaioMlTTQhhkUXL1/11wv7bvCtmRZznJuMT
 kbREp0/MHShDMpLYDGJD7L0XkUpec7vYdEq+N7WZiqudwWFCt/DRsV9iF/cRV1DtFmwoc5z3SB9
 ki3aoCSkUefhWTLgQdzSI=
X-Gm-Gg: ATEYQzwDrWz18KRoF3XcosO2w1eiXF+4++MdXKW84X1UyxUvqg5Kel+55dHKkt/AGQF
 CvLErz8FaUNWDwBcXNr2MIQdeeLYsRuqscDHEDkzQr+gJ4A1bwZJamIAGu7OXqj9aeATng68auR
 4jSIyfx7RESeaqLWcZaYyfc7FpZx2hTjgnket7JvmaM4aegUW1XU0XtZXFzYG7QpI8LB/cTqR4R
 bhy9t8dWVtCepQSe/wjA1B51nLmEQvpwbeXnJknnAfx73jhqtbmwJxY3kta00LWX0OAIA==
X-Received: by 2002:a05:651c:507:b0:387:df8:9373 with SMTP id
 38308e7fff4ca-389a5ad492emr34072841fa.9.1771919938130; 
 Mon, 23 Feb 2026 23:58:58 -0800 (PST)
X-Received: by 2002:a05:651c:507:b0:387:df8:9373 with SMTP id
 38308e7fff4ca-389a5ad492emr34072771fa.9.1771919937682; Mon, 23 Feb 2026
 23:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20260224014259.443846-1-stephen@networkplumber.org>
 <CAJFAV8yNsWO7pFH3B4-Wce=XBMNA3N4t__YL7nDpKNeojV2Dtg@mail.gmail.com>
In-Reply-To: <CAJFAV8yNsWO7pFH3B4-Wce=XBMNA3N4t__YL7nDpKNeojV2Dtg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 24 Feb 2026 08:58:45 +0100
X-Gm-Features: AaiRm51LhdFbK58Xf3JP42uBxVaTRKENghu0K2elQGD6LRGMKKIs2S3cuywHfjY
Message-ID: <CAJFAV8z0oo6zUdfYJDPJe8pJCkpZ4WVyABn0Xq1=EN=s+6givA@mail.gmail.com>
Subject: Re: [RFC] net/vdev_netvsc: disable auto-detection by default
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Matan Azrad <matan@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ISJYt6sULiMxpIXBRlBQT1dPN8h04vpckj1PIxZxB2c_1771919938
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

On Tue, 24 Feb 2026 at 08:41, David Marchand <david.marchand@redhat.com> wrote:
>
> On Tue, 24 Feb 2026 at 02:43, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > The vdev_netvsc driver auto-injects itself on Hyper-V via an
> > RTE_INIT constructor. This interferes with tests on github actions
> > which uses Azure where the driver probes in forked subprocesses
> > and crashes on uninitialized interrupt instances.
> >
> > Guard the auto-detection behind RTE_LIBRTE_VDEV_NETVSC_AUTO
> > (disabled by default). The driver must now be explicitly
> > requested with --vdev=net_vdev_netvsc.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>
> The failure in GHA can be avoided with a simpler:
> https://patchwork.dpdk.org/project/dpdk/patch/20260223155603.3651641-1-david.marchand@redhat.com/

After rerunning with debug, the vdev netvsc is still probed, but is
not at fault for the recent failures we saw.

VMBUS_BUS: vmbus_probe_one_driver(): VMBUS device
7c1e52d8-3f86-7c1e-52d8-3f867c1e52d8 on NUMA socket -1
VMBUS_BUS: rte_vmbus_map_device(): Not managed by UIO driver, skipped
VDEV_BUS: vdev_probe_all_drivers(): Search driver to probe device net_ring0
VDEV_BUS: vdev_probe_all_drivers(): Search driver to probe device
net_vdev_netvsc
DPAA2_BUS: fslmc_vfio_close_group: Get fd by name((null)) failed(-19)
DPAA2_BUS: Unable to close devices -19
DPAA_BUS: dpaa_bus_cleanup():  >>
DPAA_BUS: Portal already cleaned
DPAA_BUS: dpaa_bus_cleanup(): Bus cleanup done
Calling recursive action for test_invalid_vdev_flag
Returned from recursive action for test_invalid_vdev_flag with 0
Cleaning up /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
/home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance returning 0
Test OK
RTE>>


-- 
David Marchand

