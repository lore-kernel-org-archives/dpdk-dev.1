Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C1606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fLe3gMoM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D685540151;
	Mon, 26 Oct 2026 19:28:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id D6B8640041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793039289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DoT03dyXpCclzlizgknzRwcBBwn4KiRy+nLT95J+lSE=;
 b=fLe3gMoM7MNT1pKS5SLGR8sZPNWO7xhv2lg0hFt8lQ3/xy9aWF1ZCddHIJfl4OVj3rlNHb
 c1mq8wpdiIBhbr2qkul6+hJ+D7WkjdUW6iw/8/yiNizqTC3KWnyP887WrUzHWLgNly/VBY
 6Vf8TkHWkB2uBpKCLn7IFfYgnRWebv8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-5HU0NzKYMS6o3r_G1Rbjhg-1; Mon, 26 Oct 2026 14:28:08 -0400
X-MC-Unique: 5HU0NzKYMS6o3r_G1Rbjhg-1
X-Mimecast-MFC-AGG-ID: 5HU0NzKYMS6o3r_G1Rbjhg_1793039287
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5be4f207adbso1768906e87.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 11:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793039286; x=1793644086;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DoT03dyXpCclzlizgknzRwcBBwn4KiRy+nLT95J+lSE=;
 b=NwC0QgwKt6BxW40kQVODNR6f79PFIwZbL1eywm11vuGIuBv2bAhkuJI0hsrw6gSfgj
 9xiC4B1MbQQYCHR3hbuUdUtqSLlGlMBByy0b18m4tvXa6vOEzm0BHvpwOwJ8MZgoRF4Q
 eA4QJFyhwFiVoOzGeQx+O19KtsYw55kAmhd4t6COoOM7anb2Cfd19M7OYeuvLfrMyhWM
 ZKTNqdpF5cTZJNAbJDqIugdwyjoPO3LhjoyHR0XuU02qpKPXIAcubrRhw5PGKq7rakPE
 RK7P42LfiVPt06asahHkp10k0lcoHSOzVXd6jYlp+y/j3HOf6AUoplUWQYC+z2Sij/l0
 9TuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDpJz2rN/jW6aVRSYo3/5kkhvkvmu0Wmr3zyrwT5BIB2wlmYUMLLqfQQ8V6mIcs6pYvrM=@dpdk.org
X-Gm-Message-State: AFq9FYKua5eUwBGi0dgr/QeAk/ENNgI/bjUCLcPP8jDzrNtWHMizFOvO
 zr+D40bRBljd0nEwSqq3kNOmkDPwT1O4jQNsyyJP+WnvVpgy4FV2nMRke3uihixVKF2Em+OnZ+8
 r2t8u0mI3+MCWSV2Ag7eZtJ7aCE8/SSGZVf8Phzs10rn1H5UzfPv21IFDuKOdKBBA5goZL3ZaDC
 348ToFwpTI4ERUn3NZxZ0=
X-Gm-Gg: AYBFou3bQR6lmfdVi28mmc58bWHJa6iLOst+UiBSbKz5mmcOpMoUtqDOUSYBI3ucKgg
 R12XBnH72aN0p4kypCHqoi+hmhrqVPnoWbsesefJ4QX3GfXfTK/xMD/zZuZlEdH3HqvOwixKkv8
 7Dzc8nmr57qSdn4UOKu9F6dSvK6dIbR2Bss/NxIWp5O/ABTqYWWm7OkVpvqOCT5rkjQD5AxIWSg
 OZi8pEbU3D0peiq0yuelRt/HapCls5yxeyjCRT8rFcZmjZP
X-Received: by 2002:a05:6512:1282:b0:5be:41a1:d2c3 with SMTP id
 2adb3069b0e04-5bfb71cbfb5mr2283319e87.49.1793039286497; 
 Mon, 26 Oct 2026 11:28:06 -0700 (PDT)
X-Received: by 2002:a05:6512:1282:b0:5be:41a1:d2c3 with SMTP id
 2adb3069b0e04-5bfb71cbfb5mr2283311e87.49.1793039286027; Mon, 26 Oct 2026
 11:28:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
 <20261016093848.7dbe6c73@phoenix.local>
 <GV1PR04MB10750670E599D034FA89E627A899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB10750670E599D034FA89E627A899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 26 Oct 2026 14:27:53 -0400
X-Gm-Features: AclHuK9hseNBK7E_oOkbolvXMgWVOScykEZWdKLfKXMOIarNiLR88upDrUlVxIU
Message-ID: <CAJFAV8xx=ZM3M-DKWRtn-08zyTFhp5FC-2UptcLpZzrK7+7L1Q@mail.gmail.com>
Subject: Re: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
To: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9NOL-phcGS8FQcl1obtX3lGsT0KeVyBwYo5BQwZ1MSo_1793039287
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 at 18:48, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
>
> Hi Stephan,
>
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> >
>
> NXP Confidential
> > On Fri, 16 Oct 2026 16:49:33 +0530
> > Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> >
> > > This series collects a set of fixes and enhancements for the NXP DPAA
> > > bus, mempool, dma, crypto and net drivers targeting 26.11.
> > >
> > > It includes memory-leak and resource-cleanup fixes on the device
> > > remove/close paths, more robust frame queue shutdown,
> > > secondary-process safety guards, BPID lifecycle handling, and several new
> > features:
> > > enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> > > configuration, non fmX-macY shared Ethernet naming, and DMA
> > > scatter-gather and errata-workaround devargs. Documentation and
> > > release notes are updated accordingly.
> > >
> > > V27:
> > > - fixed qm_channel_pool_num check issue.
> > > - fixed commit message as devarg for fmcless rxq number was removed.
> > > - Added missing export internal symbol and fq destroy.
> > > - merged both FQ shutdown patches as we cannot change the sequence
> > >    because of the dependency.
> > > - mac_idx has a user which is dpaa flow so no change. Added static to
> > >    g_fmc_model and updated release notes.
> > > - Issues reported in v25 which are not handled, were optional, so
> > >    skipping them.
> >
> >
> > FYI - what I do is feed the patch into a Claude project with existing AGENTS.md
> > file. The chat continues as versions get sent to email so the context window
> > has all the versions of the patch. This lets it see the progress and check if
> > previous findings were addressed.
> >
> > Review of [PATCH v27 00/25] NXP DPAA fixes and enhancements
> >
> > Series applies cleanly to 26.11-rc1 and every commit builds with -
> > Dwerror=true. The fixes are now first. 08 cherry-picks cleanly onto
> > v24.11 and v25.11, and 06 applies there once 01-05 are in.
> >
> > v26 Warnings on 12 (now 14) and 20 are addressed. The 24 Warning is only
> > partly fixed.
> >
>
> I see only one warning in this patchset 24/25 -   is it possible that you drop this patch and apply rest of the series?

IIUC, next-net does not build in GHA since this series was merged:
https://github.com/DPDK/dpdk/actions/runs/38964568382/job/117187710778


-- 
David Marchand

