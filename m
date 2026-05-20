Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F278CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 14:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6A4C40608;
	Wed, 20 May 2026 16:54:07 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id E9EC74042F
 for <dev@dpdk.org>; Wed, 20 May 2026 16:54:06 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12ddbe104ccso3511427c88.0
 for <dev@dpdk.org>; Wed, 20 May 2026 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779288846;
 x=1779893646; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYtvcx1DH9RhSpObPzxloBzqzRBZl83RHBx6H28xUiA=;
 b=BkfLvrU5cHHbM3/NuWhkw4aPrUSmr0Hv/zUpRUSBPfPt3f2OFK11KF0wf87EzDiHrB
 lEUoONt56EMm3u0TEbLhu3IsIqvaTJRMIwu9V2Gn1yBSG6B27GhtSlK5HqyE3lz3nAlK
 RiL9JP26VRu2F/5zpzKasoUb+Cb6HnpcEDFyM0gbXwBaXf+O13WDKBYjWUFDva9es//r
 DPvREjk7XDHknEVmKSgRdBeYf8DP6kQa3h3nl4N25XATw5bRkj8zhqeDRbvNRzDhWRaY
 hvfNN1laC9hLFhQAcM8QdZp2FzOOB1QFcps2cqRw8PyPz8YYUntZji1w8p8F0tpp3gCA
 qSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288846; x=1779893646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bYtvcx1DH9RhSpObPzxloBzqzRBZl83RHBx6H28xUiA=;
 b=FCK6GTly0n3CqbX80rNbSuhp7+p7quBhEAyMtYeW4kpVeJTeWsUWfKz0W6RvqnjZ6R
 BbFwDuwqJ7zavUJOSgjbNVIKndj/9ScejpjOQb5BE0XtcMkG9vU3wLaaBUhPjp05U1NE
 Sd7MaI7AIb6siY6wPMmH1js0YW5yCvYPYx/dNxNGFxmtcvL3m1vrEVwbzbjWpnA9wFxY
 7pUY4y56kYZsaBdQyCXIqjXe3hYrgA++R/hYH/S4V10J9s3oU9WqrEZ3rP5hrpl/E9ni
 pk7Eti+q2wS+2sY9a0a1yZawROLLqnr/IDZ+ao0UxuVJtCZ+TtRFCAxNBWZKhBFePMJh
 dAuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/otl27DnqqekEWBteeWFQmKnXA3OcF7QzN92n2pLoLFlljO0JBau2yYrorlfqhydCUw1U=@dpdk.org
X-Gm-Message-State: AOJu0Yyp4KZfVkD1Mbgz4V9XfO2W7Hq1GAuy296D6CDKkgd03FDHwAjO
 NkdgjIogDkRFfKTIXPHmmwz2ADjc+ZzyNnj1JrMwdvHmmH6BiRNV+QZjEVR25NQcCj4=
X-Gm-Gg: Acq92OF5jVDWnH/FkSDY9HaWeomlrbP+fU4d2Ih2MJXwColEY4PdmTX4tJSvuN2iQ7z
 lqLwd1kXuHYLnYE2+NOCYyza65SSM1IpS45G2T+Ret2ou5BWAc/HnGLsABlQGmvse+LWmeFcFty
 qNNbaYKpZNnek+D3t4keh4g+hppBhSS2Do8aGc4Yd3OJ4I/WVIDuPky9YeqCi8Qk1Yplab+bpRv
 EBz1ux/loBevIGVBSU8/kl0fQuuvL7KbYjYHf0gANDtYL14Ul259woB4VdpajjDMpa0ubudd0QT
 wDhe1NtQrrjKFNzQyGCHP4mk7JsQdtVXew29AIcQept4LyMOKD58TFe+8tTbMt6ch1PAWuSqQUG
 hw+uXyOtAl/jUZzktmNq6dvfXCPUEYplp/Yz73ot9m03a4QUo3COA/5nu82D5BioMo+dbPoMVOZ
 tdOpvQmWivY1q6lvsS/OMNE7GJPEERwYtavGFOx6V54UKYkSET8L983NpFT+IEHLRr
X-Received: by 2002:a05:7022:689a:b0:135:26e2:9b73 with SMTP id
 a92af1059eb24-13526e29c4cmr9692983c88.5.1779288845787; 
 Wed, 20 May 2026 07:54:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb93f3sm27341941c88.3.2026.05.20.07.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:54:05 -0700 (PDT)
Date: Wed, 20 May 2026 07:54:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: fengchengwen <fengchengwen@huawei.com>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH 0/2] enhance telemetry list endpoint with device name
Message-ID: <20260520075403.5483c20a@phoenix.local>
In-Reply-To: <ag1nny7mJpM1pum6@bricha3-mobl1.ger.corp.intel.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65885@smartserver.smartshare.dk>
 <689a32bf-b6e2-4646-8073-cd1f895b692b@huawei.com>
 <ag1nny7mJpM1pum6@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 20 May 2026 08:49:51 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, May 20, 2026 at 03:31:57PM +0800, fengchengwen wrote:
> > On 5/20/2026 1:40 PM, Morten Br=C3=B8rup wrote: =20
> > >> From: Chengwen Feng [mailto:fengchengwen@huawei.com]
> > >> Sent: Wednesday, 20 May 2026 05.57
> > >>
> > >> Currently, the /dmadev/list and /ethdev/list telemetry endpoints ret=
urn
> > >> only integer IDs, making it hard to identify devices. This series
> > >> changes
> > >> both to output strings in "ID    NAME" format for better usability. =
=20
> > >=20
> > > For machine reading of the JSON output, it would be better returning =
an object with an integer and a string field, {ID, "NAME"}. =20
> >=20
> > The TEL_DICT could do {"ID", "NAME"}, which like:
> >   "/ethdev/list": {
> >     "0": "0000:7d:00.0",
> >     "1": "0000:7d:00.1"
> >   }
> >=20
> > Maybe we could add one TEL_INT_DICT which is int-value pairs, we may ge=
t:
> >   "/ethdev/list": {
> >     0: "0000:7d:00.0",
> >     1: "0000:7d:00.1"
> >   }
> >=20
> > I prefer the first one, However, the capacity is reduced from 512 (RTE_=
TEL_MAX_ARRAY_ENTRIES) to 256 (RTE_TEL_MAX_DICT_ENTRIES), but I think it is=
 enough.
> >=20
> > What's your opinion?
> >  =20
>=20
> I'm not sure about this change at all. This change is only relevant for
> those using the script interactively, for any other use, I would expect t=
he
> the /ethdev/list call would be followed by the /ethdev/info calls for each
> port to get the name. That was the basic design in mind for this, the list
> call was purely to provide the ids, any other info you make separate calls
> for.
>=20
> Also, while not officially part of the ABI of DPDK, I think it would be
> wrong to go changing the types of the returned data from this /ethdev/list
> call. Any user-written interfaces to telemetry will be relying on the
> current behaviour to list and query ports. If you really want to have an
> easy way to get the names of the ports, I suggest adding instead an
> "/ethdev/list_names" API, which can either return the objects above, or
> else simply an array of names.
>=20
> /Bruce

The new wireshark extcap needs similar device list.
Ideally returning similar format to existing dpdk-dumpcap -D
