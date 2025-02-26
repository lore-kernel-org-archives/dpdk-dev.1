Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EABC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C0974029F;
	Wed, 26 Feb 2025 14:45:46 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2484026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 14:45:45 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2212a930001so73157375ad.0
 for <dev@dpdk.org>; Wed, 26 Feb 2025 05:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740577544;
 x=1741182344; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PygRi8XUGCrOF/8DcLt7OUonDhx32ooiqdEdpkU6a34=;
 b=gGBtGN++7g8Y1Xu1ntTcKDgC4POvzdLo+R+TSHxDfBXWyWUGBaGIPnKtQXcTHo/xVX
 0s5ma9eeZYeqdGov5eN2hiM2jjcItEXszYRUerePBgqqHDYkWZhI+LarlIm6YTUykffk
 hVJvo/lKK47aBFZyFH3Swtp9xWmILWNVwAlTemfU61oxrVf5rercKicBkilqdNaCMkbI
 Q+jGvcIhC7/lgbaOEti2GvQ3JK/HdcWcu8zQsVxcv3y7dJJbx4gH7eTJhnltzuAP/Ws4
 2BpIyhJZS/8zVR8MQ0ziXqaUt0jncUpcVtvLFMhSjvyCpIMU2WMFE/lJZTYVgLHyw+CF
 3Y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740577544; x=1741182344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PygRi8XUGCrOF/8DcLt7OUonDhx32ooiqdEdpkU6a34=;
 b=BeAuow6760vBHkOiSJOELc62EpMnnwpe6sI5b356AqCTk0wm49GZSRNu9appUHJRG2
 Ub2FbhJZq127FxVwRmb0KilGPei60Hjaxt2WN5k8gKlKCuC3g7od4GQVEfV2Vc0AP81J
 t1xh4SKYG0N7diIV0cNiYa9zfcEK5JLllplpToQ0Ew3uVBqYNdvEHWlJ7ptdRshzpGGi
 UuhQBltD+KKDcnKepCT5CESHN2tpdcHrd/vesla3OWKC2XL2Hx3jTYy33c6uyQS66/Qn
 dRq1GglqVHc3nYDqtgw2c8F+VlCVvZ6r8nrpoSQ4/SRYpCGcxV5oYx7YpTN2mDEPjXJz
 FPAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBPMvgikiCLUY4e/uF9fpabub6wJK1lHgTdoCM/4/QKtbQvKok54t57S5NCjxots+8KEU=@dpdk.org
X-Gm-Message-State: AOJu0YxJlM8TCMcnjdVLbMeL7cdq49+gXpzxrDqyGlW+dwHSqUN9xAjy
 QFNcFdCEHoQhMqnvBhvHIBDRgTAtUmj2P7b/CMiV1Lf0tNym/mohlTeGVaMFrPQ=
X-Gm-Gg: ASbGncs8fxMAn7jw86DJ6Du0D7sMLGiBcgR9IkMoodu/rbeiAN9F7uvYX8K6YdRCsOK
 gpqH0WfCXOKUgp6r8o8/mvbotqkmsYNXDy0BSKSPIiJ90tMbRN5LXW80r4ZuEP3C/VjuLbHn0+Y
 6jN/yPKghrob2/X3fvL/Np5DxTpN/c4nA4c/2prYJbafeb09n16vbmUSWkVE9rbssI5dAExrspv
 W5XKmn4dWDcs4sgCyVgTA/3pjK6XGJftGZrc34arLHDAquro6oaO18iBdJpVxyvwGlnSng0mb/K
 BVai2l2Ioj7BrmMA5/CIWeJdNW2sRk+0gzb398wvhkecW8NpPz0Qesx/Xqkr7ruE96igquwVadd
 6ITo=
X-Google-Smtp-Source: AGHT+IHOcpBOP2CCO+2QHXl505yy+lt8lhrxqcWwHysGSb09zLBBjo9fXVVoyFHzA5x/hERURhcE4A==
X-Received: by 2002:a17:902:e88d:b0:21d:dfae:300b with SMTP id
 d9443c01a7336-221a0ec46ffmr355596125ad.10.1740577544247; 
 Wed, 26 Feb 2025 05:45:44 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a01fe8bsm31936915ad.54.2025.02.26.05.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:45:43 -0800 (PST)
Date: Wed, 26 Feb 2025 05:45:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] Skip vfio in the scenario of non-privileged mode
Message-ID: <20250226054540.166dfd43@hermes.local>
In-Reply-To: <ba8c70c7-a738-4b01-8df6-2df5bb0e2d7d@nokia-sbell.com>
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
 <20250117084750.3259cfa3@hermes.local>
 <ba8c70c7-a738-4b01-8df6-2df5bb0e2d7d@nokia-sbell.com>
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

On Wed, 22 Jan 2025 16:15:03 +0800
Yang Ming <ming.1.yang@nokia-sbell.com> wrote:

> On 2025/1/18 00:47, Stephen Hemminger wrote:
> > Caution: This is an external email. Please be very careful when clickin=
g links or opening attachments. See http://nok.it/nsb for additional inform=
ation.
> >
> > On Fri, 17 Jan 2025 15:28:47 +0800
> > Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
> > =20
> >> DPDK detect vfio container according the existence of vfio
> >> module. But for container with non-privileged mode, there is
> >> possibility that no VFIO_DIR(/dev/vfio) mapping from host to
> >> container when host have both Intel NIC and Mellanox NIC but
> >> this conntainer only allocate VFs from Mellanox NIC.
> >> In this case, vfio kernel module has already been loaded from
> >> the host.
> >> This scenario will cause the error log occurs in DPDK primary
> >> process as below:
> >> 'EAL:   cannot open VFIO container, error 2 (No such file or
> >> directory)'
> >> 'EAL: VFIO support could not be initialized'
> >> Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
> >> to execute `vfio_container_fd =3D open(VFIO_CONTAINER_PATH,
> >> O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
> >> in this container.
> >> This scenario will also lead to the delay of DPDK secondary
> >> process because `default_vfio_cfg->vfio_enabled =3D 0` and
> >> `default_vfio_cfg->vfio_container_fd =3D -1`, socket error will
> >> be set in DPDK primary process when it sync this info to
> >> the secondary process.
> >> This patch use to skip this kind of useless detection for this
> >> scenario.
> >>
> >> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> >> ---
> >>   lib/eal/linux/eal_vfio.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
> >> index 7132e24cba..1679d29263 100644
> >> --- a/lib/eal/linux/eal_vfio.c
> >> +++ b/lib/eal/linux/eal_vfio.c
> >> @@ -7,6 +7,7 @@
> >>   #include <fcntl.h>
> >>   #include <unistd.h>
> >>   #include <sys/ioctl.h>
> >> +#include <dirent.h>
> >>  =20
> >>   #include <rte_errno.h>
> >>   #include <rte_log.h>
> >> @@ -1083,6 +1084,7 @@ rte_vfio_enable(const char *modname)
> >>   	/* initialize group list */
> >>   	int i, j;
> >>   	int vfio_available;
> >> +	DIR *dir;
> >>   	const struct internal_config *internal_conf =3D
> >>   		eal_get_internal_configuration();
> >>  =20
> >> @@ -1119,6 +1121,15 @@ rte_vfio_enable(const char *modname)
> >>   		return 0;
> >>   	}
> >>  =20
> >> +	/* return 0 if VFIO directory not exist for container with non-privi=
leged mode */
> >> +	dir =3D opendir(VFIO_DIR);
> >> +	if (dir =3D=3D NULL) {
> >> +		EAL_LOG(DEBUG,
> >> +			"VFIO directory not exist, skipping VFIO support...");
> >> +		return 0;
> >> +	}
> >> +	closedir(dir); =20
> > You need to test the non-container cases.
> > If vfio is loaded /dev/vfio is a character device (not a directory)
> >
> > Also looks suspicious that VFIO_DIR is defined but never used currently.
> > =20
> Hi Stephen,
> For non-container test, /dev/vfio/vfio will be character device, not=20
> /dev/vfio.
> Here is the command result on my testing environment with Intel NIC.
>=20
> [root@computer-1 testuser]# ls -l /dev/vfio
> total 0
> crw-rw-rw-. 1 root root 10, 196 Jan 22 01:50 vfio
> [root@computer-1 testuser]# dpdk-devbind.py -b vfio-pci 0000:04:10.2
> [root@computer-1 testuser]# ls -l /dev/vfio
> total 0
> crw-------. 1 root root 239,=C2=A0=C2=A0 0 Jan 22 01:52 59
> crw-rw-rw-. 1 root root=C2=A0 10, 196 Jan 22 01:50 vfio
> [root@computer-1 testuser]# dpdk-devbind.py -b ixgbevf 0000:04:10.2
> [root@computer-1 testuser]# ls -l /dev/vfio
> total 0
> crw-rw-rw-. 1 root root 10, 196 Jan 22 01:50 vfio
>=20
> Can you confirm your test scenario?
>=20
>=20

When vfio-pci is loaded but no device bound:
$ ls -l /dev/vfio
total 0
crw-rw-rw- 1 root root 10, 196 Feb 26 05:39 vfio

After binding device
$ ls -l /dev/vfio
total 0
crw------- 1 root root 511,   0 Feb 26 05:42 15
crw-rw-rw- 1 root root  10, 196 Feb 26 05:39 vfio

So testing for /dev/vfio is good indication that module is loaded.
Not sure what I was thinking earlier.




