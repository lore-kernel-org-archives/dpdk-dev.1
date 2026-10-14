Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5B3CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:16:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E11402EF;
	Wed, 14 Oct 2026 19:16:54 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 5F8FC4013F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:16:52 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2772605a91.2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791998211;
 x=1792603011; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5uslSl7OGzigDF5hLyawJoDQATDxzUu3wlBWJYw+Kbs=;
 b=BNC1x2N6CLeDF4jTTCIYvLEetm37LhbSDKPibXIE+hKYJ48I4cDMA9AdsvOm6PxnIg
 bnrEZ7RGtHnJNZJE0XgTRSUWF54msA8rz7ImcQ8ngTFuFzpdEYVZ4tsu97PSKlwnLi/U
 NMUgQLyfoUOEN8bCZJSux6EFwlYkTVhD24sUB7cLJwyjSWPEUP2w2E0T6GrotDgViHHN
 zxp9nQDH1e5L4ejppEU/Xba0zSoz2V67NME5k1y8/Ph6nantNXGu8VqGA/DD8sA8sWb1
 dx+jBcuvPYiW7sGI/+xvjfMKsdUppUEEhm1nGQLM+DRB3trU2vhIcLT096r7dEyn8lZ9
 Rezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998211; x=1792603011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5uslSl7OGzigDF5hLyawJoDQATDxzUu3wlBWJYw+Kbs=;
 b=UAxachGa0MtOw9+xixIdL59Gq48VIjYCLe4je3IZWLcei7MZ2n5cvVNjC9uHDJJuR7
 5h1XvhMV8gh+VmeJ7IGWKkx1C1vpZ8TP/OQRFejBN82luypTc+/bGMYRuovM2GslHLur
 yJuCuPnU1USwfT/UrENvGOzDS6NOZ83yIzQRAyN0wVcxHJrWl1FIhJ/Gbp3mWt4emVnB
 6dDUaUwa/vhUokNK3rd1yeITtgHauBWr0VLSDq1lcqXOvWrpoDt7rTn1xCA0wGNH6e+E
 TYSTuEBF3PJ5TQrNYfqLA0KQK6Frjqn3NiMW7lpIiLgBBJYbK9eOqU184GpvuA9uyXeM
 1mAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0rTe037hcXYcL63YJzp2YYdToBhJbL1iSmrDG5uG65N1PitzJnqWIcGdGY77YlmYemGY=@dpdk.org
X-Gm-Message-State: AFq9FYJonW6c/zmPQCmSXaKPcocWXPSp/fZVmIGxq+d0ZhQF+C31dsu5
 mkdvxO7PNj0f4EDMFinzzdNo/RMqp+7rtVj2WgNjQU1tQVaHtSTKzoq+cMpOm25J88E=
X-Gm-Gg: AYBFou0VeZRnyxwSCs/H1819zSjE0jY0JkFmY6zvv1amxdIhdJfIUlx6KOL2fBneA9Q
 jPCYIDVnQ21a+jAtaUTy6cRC6uXQnYSZ3A+VDpO2cTtkmmbRdg3c3gpPT8PjiYgsibZKxXb5qHJ
 ziinAB9/BL5kmkV4uE+IaQTX43ONqiTJx1DCyf0Zq423231s6S90GrjUOSyXNgl16VS2nZVBVkb
 PPu+Z3dmNS3Lmkx2f/GeL0Ijnz9sN0OxgJ7ZpvokHvLqiD4+IKfz+18AWHeXnzaMgmZmDvl12MU
 x6/f0jhVdXruA2fSA0jAg2HPv53oziyTXS5BAGscr/7kb6E2lCiAKGVIg47LED88Afc3CoB/tPP
 YgqW779R4/lTUQWHoPpCD8JvFtov/mYj71Qy6sP+WeLjXU9MzCcBqxxqysyTQuBHOMIh5Vep9Jm
 vXzqThiXw01F3q5fmhXU91TzgyPkjffqBvllqMmLngvR1cJIOcWLdCmlBH/nurGev9kUVjtuuF7
 2ZkJWRjYYXrvvnDv0xkWxWOH+lgOwG1D10klvHE
X-Received: by 2002:a17:90b:3d89:b0:3ab:c6d:2bf9 with SMTP id
 98e67ed59e1d1-3ab3afdaaacmr14746933a91.57.1791998211408; 
 Wed, 14 Oct 2026 10:16:51 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac947928b4sm241104a91.11.2026.10.14.10.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 10:16:50 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:16:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Yongji Xie
 <xieyongji@bytedance.com>, mst@redhat.com, jasowangio@gmail.com, Bruce
 Richardson <bruce.richardson@intel.com>, dev@dpdk.org, chenbox@nvidia.com,
 david.marchand@redhat.com
Subject: Re: [PATCH v4 1/9] uapi: import VDUSE and VFIO header from v7.3-rc7
 kernel
Message-ID: <20261014101647.1164eca0@phoenix.local>
In-Reply-To: <20261014082930.96261-2-eperezma@redhat.com>
References: <20261014082930.96261-1-eperezma@redhat.com>
 <20261014082930.96261-2-eperezma@redhat.com>
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

On Wed, 14 Oct 2026 10:29:22 +0200
Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:

> This header will be used by the Vhost library.
>=20
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Please only use uapi headers from released kernels.
