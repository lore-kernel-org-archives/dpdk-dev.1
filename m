Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A954C3600C
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 14:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A99440613;
	Wed, 26 Mar 2025 15:47:55 +0100 (CET)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) by mails.dpdk.org (Postfix) with ESMTP id A6C83402E0
 for <dev@dpdk.org>; Wed, 26 Mar 2025 15:47:54 +0100 (CET)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-54996d30bfbso6441822e87.2
 for <dev@dpdk.org>; Wed, 26 Mar 2025 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743000474; x=1743605274; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJyZscT9jgyThkKCJZ1/lx/PQUYmOdDr89attjb19OU=;
 b=H9XiuNG/q7T2lnB8nmymcRSN2kyEKTiphtrhYbWshr9+PW5XQJ1VLuGTtgDLtLacs3
 9xmiqpVNVg+cAu8cDu8XMbVHCcS9LNb2L/ebym9GXwZp3nlnLtb3bSnfsLWd/lXoFUe9
 qjiRNoj4chwG+qd95dQuoc7zSdFWYhBlbdab4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743000474; x=1743605274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJyZscT9jgyThkKCJZ1/lx/PQUYmOdDr89attjb19OU=;
 b=R83BrHh5QV8xRCmnDtRJx4rtOXxak4xvM9Q34IoqSDmTUKPNcuJx6aXA5YpsAGoY9g
 bZWKXKMxWZXVI4ChaW5hKqUwIJrQASZgZ7tLePOVQjPyttMU+mSlNxk/SiQLvh1L2I42
 OMfqcO/Ky/ITFHEKEK49N4ktLDqg9b0oxuXOunTE6nuN9mqhYSsFCO9+m4E1smSuTiT8
 whv+b2OxST+JKFbUD38aAXpbgab5p/C5NKyoyaxq8tOfAvYDZutRUbPBXPFKoTxScH2p
 FFsZQkMRTh9hruCMUruvPyhF2RHVecJdae9XhlEhywToScTL1ElQ5BBHXl8++9VtLb/p
 9b5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUusbW/OPhx/2Q/ACtbesG7KmlmuvLs1TvgxggLPBY5w2M/gA1m5WWDKAAjViiujc2+sww=@dpdk.org
X-Gm-Message-State: AOJu0Yx+l6K/PpZUV4LkPheVer/Eov/YSuLKqAxpu45YS1vSMoO9jPVR
 j4qf0ExoS50Pkl9yq6eyjL/2+jvYlRsvj9LJopqPhUxpBcmSZTpiuydGNTw4CTSHQwIg9uDykh3
 QSZ+3XaH4dA+XXAt0yRk4H8/dgUBWO5NLpWhf9A==
X-Gm-Gg: ASbGnctCwWyH0m6sSOhcpjSv9PkGQSq1yMh2Mk7MHvsAO5JuA7Mo5iwMoCJjLVwatQJ
 6XvEwenkBOEnUaiLVNtj47nmSJYhyFVoLDunLijXVWlks/2Fh73MpuRQRBDlTSpK7P+avqDDZg2
 DJnJw9pOoRerHVKMCKAaOZP53R2WuEneU1EfB3bQCq8N0wwJ/f6iUpbbDXZKtM
X-Google-Smtp-Source: AGHT+IEoVgE8ReMg22C9WIRoY+Zb3CexaEWve4lz0vdqMrgEjYvBL2zGLL13RsQ8j7DZXClyA4PFVma/CQjT65ykFtg=
X-Received: by 2002:a05:6512:1589:b0:549:4bf7:6463 with SMTP id
 2adb3069b0e04-54ad65004abmr8117515e87.44.1743000473876; Wed, 26 Mar 2025
 07:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAMEVEZvCoVpMjFpmY29-x0zB2tQvNrJsTacs6-Zzx4jJB_GsoQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
 <20250321085259.095bd234@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB3B@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB3B@smartserver.smartshare.dk>
From: Cody Cheng <ccheng@iol.unh.edu>
Date: Wed, 26 Mar 2025 10:47:42 -0400
X-Gm-Features: AQ5f1Jpeqo-Dw7d7cB34avSA4LNRdMuPJILea2WOOJzfY1ToFrLLduYMoloP39s
Message-ID: <CAMEVEZutf4sJ=EQFONw_bJW0tGTWqTbF_Tk_y38qzBLccco46Q@mail.gmail.com>
Subject: Re: Clarification on Minimum Supported Kernel Version for DPDK
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kevin Traynor <ktraynor@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, techboard@dpdk.org, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 Ali Alnubani <alialnu@nvidia.com>, galco@nvidia.com
Content-Type: text/plain; charset="UTF-8"
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

I=E2=80=99ll set up the CI testing environment on kernel 4.19 as per the
current minimum requirement then.

Thanks,
Cody Cheng


On Sat, Mar 22, 2025 at 9:02=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
>
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 21 March 2025 16.53
> >
> > On Fri, 21 Mar 2025 07:28:45 +0100
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >
> > > @Kevin, @Stephen, @Bruce,
> > >
> > > I cannot reliably answer Cody's question, and it may need further
> > discussion.
> > >
> > > What is your opinion on minimum Linux kernel version requirements?
> > >
> > > @Thomas: In the future, the DPDK release notes should mention the
> > minimum Linux kernel requirements.
> > >
> > > > From: Cody Cheng [mailto:ccheng@iol.unh.edu]
> > > > Sent: Thursday, 20 March 2025 21.28
> > > >
> > > > Hi Morten,
> > > >
> > > > I am in the process of setting up a test environment at the UNH
> > DPDK
> > > > Community Test Lab that follows the minimum supported kernel
> > version
> > > > for DPDK. According to the DPDK documentation, the minimum
> > supported
> > > > kernel version is 4.19. However, the oldest long term stable kernel
> > > > version listed on kernel.org is 5.4.291.
> > > >
> > > > Should the test environment be set up on kernel version 4.19 or
> > > > 5.4.291?
> > >
> > > The kernel 4.19 support stems from still supporting RHEL/CentOS 7.
> > > I wonder if this exception mentioned in the documentation [1] is
> > still valid, or if we should bump it to RHEL/CentOS 8, which ships with
> > kernel 4.18 [1].
> > >
> > > RHEL/CentOS 7 support was discussed at by tech board long ago [2],
> > but I cannot find a conclusion about the kernel version; the discussion
> > was mostly about compiler support.
> > >
> > > [1]: https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-
> > software
> > > [2]:
> > https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/htm
> > l-single/8.0_release_notes/index#overview
> > > [3]: https://mails.dpdk.org/archives/dev/2023-February/263516.html
> >
> > My opinion has always been that DPDK only offers certain guarantees
> > about testing:
> >   - oldest current LTS
> >   - oldest supported version of Redhat/Ubuntu/SUSE enterprise kernels
> >
> > after that in the embedded space, the user is likely to be ok but any
> > kernel
> > related issues are their problem not the communities to deal with.
>
> Generally, if some new DPDK feature requires a new kernel (or new kernel =
feature), the details should be mentioned in the release notes.
> And preferably, that feature should degrade gracefully when the feature i=
s not present.
>
> For the embedded space, we could support the oldest current version avail=
able as Super LTS [4], which is 4.4. And for now, we could stick with the s=
econd oldest, 4.19, which is what we currently have.
>
> [4]: https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#k=
ernel_maintainership
>
> Some old kernel version might not be officially supported by the Kernel c=
ommunity, but an embedded vendor might have tested the relevant features ex=
tensively and thus trust it more than some new and officially supported ver=
sion.
> So let's not require a newer version than we absolutely must, on technica=
l grounds.
> It seems that kernel 4.19 is the current minimum requirement, so let's st=
ick with that, until there are valid technical reasons for requiring a newe=
r version.
>
> Anyway, it seems we need to clarify the policy for kernel version require=
ments.
> It's easy regarding the distros; DPDK running on those require their ship=
ped kernel version, at minimum.
> It's for everything else clarification is needed.
>
> And it's not just embedded. Virtual appliances can be tricky too... with =
our SmartShare VM we had to add support for running as a guest under an anc=
ient QEMU host version, because that is the hypervisor used by one of the b=
ig system providers in our most important target market.
>
> In non-cloud market segments, a lot of really old stuff is still being us=
ed in production, working perfectly fine.
>
> >
> > The two parts most likely to cause issues are vfio-pci and vhost
> > related stuff.
> > There is also small chance of issues with the memory handling in EAL.
> And maybe handling of many CPU cores, and most likely something related t=
o the new cache steering feature.
>
