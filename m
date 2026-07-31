Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD22C54F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 15:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB8F9402E8;
	Fri, 31 Jul 2026 17:28:02 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 8017E40288
 for <dev@dpdk.org>; Fri, 31 Jul 2026 17:28:01 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1205024a91.2
 for <dev@dpdk.org>; Fri, 31 Jul 2026 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785511680;
 x=1786116480; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VmJY3TWkTd+Qy/ECNapj1IwA/1ZCSu+NpVPSz2HxoHc=;
 b=YSBTGaRYoQjIC53Rm7ixyLtN498vHuHUrg2txLlFDbQaX+N9kHzgVBo0nBQFLHL6Co
 QZ1mLhQG/kqze8UoK8atvQPJDlP+FTdG6mzFkpQgvXTAfALIUy3S0oxnD02rVqd9FT5R
 jRimI96DAU/mZtqNSilj/MC4HfnZFwxdFeLG4K6RKCp5MzL0m+s/QJXm3+nH0diJ34F1
 fN17HHw8hnIY4wvz2XHISo5cy5TErVJurMcYV5FIPu6Ag6ZCgdwG/WiR8iKLKvN8pzlC
 OAy5/eJXeOzL4UdLet5vIkPr79UPV+NdX3RmyhcHaLVHgD8L15bkpKBIY+tZUpr+OMiB
 qUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785511680; x=1786116480;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VmJY3TWkTd+Qy/ECNapj1IwA/1ZCSu+NpVPSz2HxoHc=;
 b=phNziBdxbH/s6vqnHy0vlrraWVBfISX0KLREYTxPVAK2x6NnP0vvNoEJfdGM6AsUjR
 zYu0sKo+h1AUzDdNmcfuf4tgRKAlpUKaiAJ9ArkS5feZaoZpV4U1/ps6ysrbxdB0LnyQ
 FhYIo+eYZRYSrryk5xgidJ0zVUYSucDJvtOmi53If2Y3eorxu/VUtac8YjAFHGcCd0r6
 zzGwMPToRq0gV/taN01PWsBgmpZRbARK11M7qp/uXslq5w5Pd2KmmXfmAEXFqN24wt2P
 ZvshS0mTzGFI2nvssopRBsnYWNeTaaEHtuihM0S21GAUEpv018IBzhNHLU1ZkUlzMqWo
 5TjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqX36WBTzMvyOIkKZTBKPnt7H14m/UPG/y/iIcM+YwHXrND1zrdKN+rZwo0VdzROhsGgI=@dpdk.org
X-Gm-Message-State: AOJu0YwSCWsKeXSxnsNogNEQlWJxQE0MtyN5K3CbeVXvE7GJNQLscoec
 7v1xAl02/BObUjVY45KFYTTHPwZ3pwRVWJkhzCd5vLaWzer6bcGRci0rzVsPnT00V0M=
X-Gm-Gg: AR+sD13mv97Y28HxcxdnmhtfsgR3+GRM7jEV7+aWbTHsglGEt9HVA4rSmNSNkF0gARN
 GfodXA6HpjlGszOqv77pPk8qalIJdvBbvdhN+hGxlDz1LpJBHAMyit92LLvzwwHLVtEYASX7fiD
 H2Hqy+SEmI/h6/gTSqYqVYVFBNfjw8J1ORQeHl0sBjSP6HmDDTqIXEqaJ+gxaZ4P9xXtzBfsVcp
 Jtudoffkw+Yna/gj5lDrF59NTMjMnKCGOA8H9dI5VIxdSX0z8h4YxPd4v1fNTTqSl9PaInNby7A
 YPVMqMdIiWEZfZuaxQHZfzmEl/tqPmRPdrHb61Tj0Le+G4vrrdaTde96MeeUxsqIbGdOCaLczEj
 ZHlcbuvba0Fmt/16Et4HwgSQ5cbUxtvygfurSDJxqw++rqczj7HUoUzbRe8frhBfW9QEaF8SCEj
 5unf4plalK/OJnDcauwYphBsBGDKpp82yabn9vQTWwAMC07jOMP1W2PfbVEX+1Q92v/T8SXXsYv
 ukMvOD9+5ZsTsJbU1Ct856z1buh8w==
X-Received: by 2002:a17:90b:1d48:b0:38e:7f34:b23d with SMTP id
 98e67ed59e1d1-38fbc598be1mr301215a91.35.1785511680246; 
 Fri, 31 Jul 2026 08:28:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e18e114sm13710955eec.28.2026.07.31.08.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:27:59 -0700 (PDT)
Date: Fri, 31 Jul 2026 08:27:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>
Cc: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>
Subject: Re: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Message-ID: <20260731082756.31f7a9d8@phoenix.local>
In-Reply-To: <IA0PPF659BD4C46C174C843A7FE6C0208C2F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
 <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
 <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <CAJFAV8xPCRAerr-goiD5UbxPjmy5ddyb0ew8FK+nZMdu_g1kDQ@mail.gmail.com>
 <IA0PPF659BD4C46C174C843A7FE6C0208C2F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
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

On Fri, 31 Jul 2026 08:19:07 +0000
"Bathija, Pravin" <Pravin.Bathija@dell.com> wrote:

> > > While the immediate motivation was libblkio, the spec's compatibility
> > > clause was written for exactly this situation =E2=80=94 any front-end=
 could
> > > make the same mistake. QEMU's libvhost-user reference implementation =
=20
> > already tolerates it (see vu_rem_mem_reg).
> >
> > Which does not change that I dislike such compat. =20
>=20
> I couldn't agree with you more.  The libblkio fix is ready and will stop =
sending the fd.
> In an ideal world we'd fix libblkio and move on,  but there are already s=
everal released versions
> of libblkio in the wild that exhibit this behavior.  Users pairing those =
with a current DPDK will hit
> a broken connection with no obvious workaround.

IMHO security safety trumps the specification in this case.
Although it might help to document this somewhere and add a better message.
