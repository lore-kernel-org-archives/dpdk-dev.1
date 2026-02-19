Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C9E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10506402CC;
	Thu, 19 Feb 2026 10:05:56 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 2628A402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:05:55 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8954c181830so8169036d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771491954; cv=none;
 d=google.com; s=arc-20240605;
 b=d2quEG+75fsHiUZqGicfwlr6IL1yobHlxtlWpHw5YapxY9RRIRtR9s70pWq/U1dFGP
 uVmPQIouT/u7+MtU/qdk9my13TyCSFTGHQCtqdW5HOcgehC9pX2URE0fi+kPtSGEzF8G
 yMjqqyQtpErekFvm1jigQFYjQgxoX2uotVfYAHS7nhgrio3Bo7E7Uso812Zbvu98h10h
 NOu34lgD11pG3osQqUR7SA6EJpGdPb6tPSPOqktZBLbtqOX2Rd7QkACj5n5erGNyTw/s
 fnRVQQY9Nq3oniiPRMr/I/04w+9DCSQqBhGNn5tcEbPuCEVPWJdQE9Z/ptZkfxMDKjPT
 y1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=fznsyADLQl8X9QTV2HOjZZkw9tFpSPlmWuiWVg2YGiM=;
 fh=lJ5ZsS44s+lXwCAnWV+6jwrszKl7lzxhKjspvIqcysY=;
 b=BV45ua5Moj69AgxKQeys463uW7IJJLdc19jhyvgu2xYIRba+KvzeJiPV+9DX/x8+iD
 MrS+M4k+nJ+alNU341qivPLR5obathaiPxQ4bGgDsfmnvd4RBZHYcdTBKt4vXHnmd8Fs
 EGDRY+JN77kXgKTlrF0uqbBNIoRn8hSLGfBC9HI91AE52gAduxaNJ4jZKf/dVPMb4o68
 +74x311EHle6tBMo8ws4TWrkAMjA9Uk+IqDs0ZXZvwmgccv9iWqYMVLKgLUGiulqYH6r
 bKtxtVPCs+Q/RHmDWQmyVBAsiDEqtt9/IJvSx3Z0D25WW5oIvxS1bSn6a0aDZXsFoJrK
 mY7w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771491954; x=1772096754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fznsyADLQl8X9QTV2HOjZZkw9tFpSPlmWuiWVg2YGiM=;
 b=IdRSoy0l9fPyOzm8I+8E4XRon+8bRvfkBUCYHermngTsQHVgQvTI3LxaNZLEWSukFu
 bXKZRMsRaXalKbu/9w8O/pJDlmgJA714ps/WlAtfznI/KUUEF2yjMwNNTbsy0ocZFxD+
 aYnqDHR4H8sGja3nNIvERKZw7L9w3Inm44xCSWuqe6Ub0+NXm0IP0XVi164J/yUc+mN6
 /Hwxm/1qw/q4s0aH8K7OmO00svot2nqMnmf6skuE9oOdcXAyQdCZKawUeWxpTZ9FgDrO
 7f72V6Rc+5UEeE3ppBmIHdFVO/esRaS7snQN2Pg8nFRuB2a1qq+y5Je6C+MCwkN8MrZ/
 aiBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx5ImxSbcbmwa2xXctOqg6tELWsCOaPm+tU5hMxIRizwQ6S1qtSpjrX03y+x/3BEVLNv8=@dpdk.org
X-Gm-Message-State: AOJu0Yym4VnJoS4aAfMT/mXrI50PZzI6UqOpAN/g7VTMHjpAqgitsBcu
 WdxWyB/rO+ABi7wqkY8PK+EJS4QUkXWRjnKeyXiFo80GWbIMVLLvwWs5Zu6/9kAfyZyXfokfeCr
 ae1kPIzd7VvhNZvfquIDmvcGTRlSqyLA=
X-Gm-Gg: AZuq6aInPvCDVEbAGNkVDx+dRaCczfB+mDrRlkK2Qfk9/+CFW6vpN93YOqilGOl5+d0
 +x3TuYSynXDPOspJvOVUJ1PA/8z2LireDCh6jSLfBg744CL/YtRtb6U+RkH+ETPxHqw+k2G8oNy
 bPqu8nvrkSP+r0i7WPNKuAJKO1QqowyE6s/feUDpVsQ4h3M3uDq9M5gpTIyIcBb0q4aZ4dUcuwR
 HwlXHjvmvSeB+blHMS4USuxHONjlJVMnudZPX6DZdzj6pHecP0XORrPC3MOaswbJ/5Fui8NEuoT
 P0WWIvLonhhwLNhrAYJd3grBNf+5kSnJc1YLZQ==
X-Received: by 2002:a05:6214:1c8e:b0:884:5e18:e91a with SMTP id
 6a1803df08f44-897402d5612mr269120256d6.2.1771491954291; Thu, 19 Feb 2026
 01:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-11-maxime@leroys.fr>
 <CAJFAV8z=CfhvELVRPJMteB+LwTwET7ZdaOuA9eyL3OaVGmPMjQ@mail.gmail.com>
In-Reply-To: <CAJFAV8z=CfhvELVRPJMteB+LwTwET7ZdaOuA9eyL3OaVGmPMjQ@mail.gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 19 Feb 2026 10:05:43 +0100
X-Gm-Features: AaiRm51jkg6Y9kvecGaVVoHCqRUFROpbqPjquQQRuZPutt2W3F-jo840cJMZ6IQ
Message-ID: <CAHHRULXWDg2qpc-WR1pehzZ6+PasdeNx3aqOjVj_0K12Zk-UgQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] bus/fslmc: fix devargs not propagated on hotplug
To: David Marchand <david.marchand@redhat.com>
Cc: hemant.agrawal@nxp.com, dev@dpdk.org
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

Le mer. 18 f=C3=A9vr. 2026 =C3=A0 17:45, David Marchand
<david.marchand@redhat.com> a =C3=A9crit :
>
> On Wed, 18 Feb 2026 at 17:06, Maxime Leroy <maxime@leroys.fr> wrote:
> >
> > When a device is hotplugged via rte_dev_probe(), the EAL adds the
> > devargs to its global list before calling the bus plug callback.
> > However, fslmc_bus_plug() never refreshes dev->device.devargs from
> > the EAL list -- it was only set during the initial bus scan.
> >
> > As a result, PMD-specific devargs (e.g. drv_no_taildrop) passed
> > through rte_dev_probe() are silently ignored by the driver.
> >
> > Refresh devargs from the EAL list in fslmc_bus_plug() before probing,
> > the same way it is done during the initial bus scan.
> >
> > Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
> >  drivers/bus/fslmc/fslmc_bus.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bu=
s.c
> > index abdb0ad50d..a539753649 100644
> > --- a/drivers/bus/fslmc/fslmc_bus.c
> > +++ b/drivers/bus/fslmc/fslmc_bus.c
> > @@ -596,6 +596,11 @@ fslmc_bus_plug(struct rte_device *rte_dev)
> >                         struct rte_dpaa2_device, device);
> >         struct rte_dpaa2_driver *drv;
> >
> > +       /* Refresh devargs from the EAL devargs list, as they may
> > +        * have been added after the initial bus scan (e.g. hotplug).
> > +        */
> > +       dev->device.devargs =3D fslmc_devargs_lookup(dev);
> > +
> >         TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
> >                 ret =3D rte_fslmc_match(drv, dev);
> >                 if (ret)
>
> This looks like a strange location for a fix.
>
> The hotplug path calls this bus ->scan() which is supposed to refresh
> the devices.
> Could you double check if something is wrong on this side?
>
Hi David,

rte_fslmc_scan() is guarded by a process_once flag and returns
immediately after the initial bus scan. During hotplug,
local_dev_probe() does call bus->scan(), but it is a no-op -
scan_one_fslmc_device()
(which calls fslmc_devargs_lookup()) is never reached.

The device already exists in the bus device list from the initial
scan, so find_device() succeeds, but its devargs pointer is stale
(NULL).

You are right that insert_in_device_list() does not handle the comp =3D=3D
0 case (unlike PCI which refreshes the existing object and frees the
duplicate). Fixing that and removing process_once would allow scan to
properly refresh devargs on rescan.

However it is a larger change: beyond the dedup fix, device_count
would need to be kept consistent, and fslmc_vfio_process_group()
removes infrastructure objects (DPMCP, DPRC, excess DPIO) from the
device list during the initial probe, so a rescan would re-insert them
as new entries that would need to be handled as well.

Making the fslmc bus scan re-entrant is a significant rework of a
critical code path, for a use case (true hotplug of dynamically
created devices) that is not common on NXP platforms.
I think this is best left to the NXP maintainers who know this code
intimately. My use case is grout, which uses the EAL hotplug API to
late-probe devices that already exist in the DPRC at boot time.

That said, you are right that scan is the proper place for this fix.
Rather than making it fully re-entrant, a simpler approach is to
refresh devargs on existing devices when scan is called again:

 if (process_once) {
     DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
     TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next)
         dev->device.devargs =3D fslmc_devargs_lookup(dev);
     return 0;
 }

Let me know what you think of this approach.

-------------------------------
Maxime Leroy
maxime@leroys.fr
