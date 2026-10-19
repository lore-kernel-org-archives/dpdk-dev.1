Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2D606A328
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HyCLT57Q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 737E840297;
	Mon, 19 Oct 2026 22:12:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A0A644021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792440760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0oIwgPyqmgoq943nywSuKqx8vVffvJWJATfTB01t/4=;
 b=HyCLT57Qs7mI8I6pQilJI3C8uaxKLYYXomLpS4dp21vl83mRLgHwGLrPk/BrMXOmd3rmAY
 x3qIDY1nvUnHtDglb3hBySCkY714dlxYGqgVYEt0Hx07Z5w0uBj8w9d7+/xOys3rpJZmIv
 pLIYp5MRC+xX17K3qefoGboNmstQPfw=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-SS-VJbZ3Pwm01STk61fxqQ-1; Mon, 19 Oct 2026 20:12:38 +0000
X-MC-Unique: SS-VJbZ3Pwm01STk61fxqQ-1
X-Mimecast-MFC-AGG-ID: SS-VJbZ3Pwm01STk61fxqQ_1792440758
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso4829097c88.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792440758; x=1793045558;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X0oIwgPyqmgoq943nywSuKqx8vVffvJWJATfTB01t/4=;
 b=BwwmRUiUHf4WcFfKfUSoCmotk1czFQSzoymYoJTRLxlmJJi2Vlda3S7EEZHnXJ0DXB
 XmpecyO1LoHS5yMYiyzMwAOwFWIG+j4ZPYsk9RoRuwqGd4pWWcLenZMpFZktOe1NF6z0
 Kp3wwo7+zfntDE14+wEtbz0EqQPhZV/WNdsUrkzxigGetWu/bii8eE/Ck6hOUR5dgvs6
 p3fbymW5+hxGCC5cIqEZHTGONPVLgyVMQh89q4jL8Ii6Td8ps2U7oPL2NsRNQzW54dg5
 He81ua9tr+23xUduszHzTp8z60BITnMkUeMANXTeItws3366pLfIv7JPQYX/ozrA1I85
 N0kQ==
X-Gm-Message-State: AFq9FYJirjRSMNlDujRKK6EPVVVmirMyukAAduI78q7xO0Gmc4N0UUMn
 ddJZolGJPg1YG2P7FpwbaDyUnmQ5rdu7lCg3Xe2dSuFKyQ9uUHG5zoBq+l6fZhqMOPyykPM+ySy
 fyvymgdhr+hFXUkF47c0djtRX75JSPXQBpQLlifyuYVedYwa4oHXAvdIh3/ti6AVIuQD7hJZApk
 m/FmCKfNlqxrBum8qHaUM=
X-Gm-Gg: AYBFou05T3UhFBl4zQy7kvlT1S/9Nuo4tZCOTibwC09ovxbX3pyBC1fF+6HFDtBtWzx
 QpB3o8j3GfptNaXIgJTH+OxqtvAFDb9kb7TDM0GqlA3yjv5vvSiMPRh32Vxj+H9RDAKpcnrSdKt
 s0CvI3fjDLoPBCOPzOpsR/8F0xWHCbCuQOcQnl27uDA3Su9WO+FJL7HEUYRs8+1re9fPZeAsLGn
 8XqCAZ5NoDPh4RQL2wQjQ/DPajGxsuO//HxzB4lnlQ3uJLJLhBi1te5I587FoHYLR2BiUfk8WBM
 1PRiAWclW11BUIQpqErB9MkX6pfuo3Vn9ghR+hDeEoI=
X-Received: by 2002:a05:701b:4515:20b0:144:eab0:9cbc with SMTP id
 a92af1059eb24-18513b9a5f1mr12521270c88.37.1792440757546; 
 Mon, 19 Oct 2026 13:12:37 -0700 (PDT)
X-Received: by 2002:a05:701b:4515:20b0:144:eab0:9cbc with SMTP id
 a92af1059eb24-18513b9a5f1mr12521206c88.37.1792440756832; Mon, 19 Oct 2026
 13:12:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017165952.3139535-1-mb@smartsharesystems.com>
 <20261018092037.3143058-1-mb@smartsharesystems.com>
In-Reply-To: <20261018092037.3143058-1-mb@smartsharesystems.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 19 Oct 2026 22:12:24 +0200
X-Gm-Features: AclHuK-JMqLO-XJVy82TLHwQOUnPG8EjHxPaB4IxszHF_RZvNaw2UngEJt-n5ZQ
Message-ID: <CAO55csz5i1-b+7XYgVZad2ZxU1+_egNR+HkPCfD2=B3Q6zdErw@mail.gmail.com>
Subject: Re: [PATCH v3] net/vhost: fix SW checksum when zero
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 43lbbCjXw5e761OdfYaRwkYkfaW3L-skrZr1OTsdGmc_1792440758
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 11:21=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshares=
ystems.com> wrote:
>
> There is a special rule for UDP, where a checksum of zero is as 0xffff
> instead of zero.
>
> Identifying packet types requires masking with the mask, not the value,
> before comparing to the value.
> Identifying by masking with the L4 UDP packet type value (0x00000200)
> instead of the L4 packet type mask caused other L4 packet types to match;
> specifically IP fragments, IGMP packets, and certain non-fragments.
> This meant that some non-UDP packets followed the special UDP checksum
> rule, which they should not.
>
> Updated to mask the packet type with the L4 packet type mask and then
> compare to the L4 UDP packet type value, so only UDP packets follow the
> special UDP checksum rule.
>
> Furthermore, according to the mbuf documentation, Tx checksum offload
> requires that "ol_flags" is set, and only mentions "packet_type" for Rx,
> so use "ol_flags" instead of "packet_type" for checking the packet type
> at Tx.
>
> Furthermore, writing the checksum needs room for 2 bytes, not 1 byte.
>
> Note:
> Using "if (unlikely(cksum =3D=3D 0) && PTYPE_MATCH)" to advise the optimi=
zer
> about the need to evaluate PTYPE_MATCH being unlikely.
> The probability of cksum being zero is only 1/65536, so it's better to
> branch early.
>
> Fixes: 8ba1723783b2 ("net/vhost: perform SW checksum in Tx path")
> Fixes: 8f1750f42e2d ("net/vhost: perform SW checksum in Rx path")
> Cc: stable@dpdk.org
>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
> v3:
> * Writing the checksum needs room for 2 bytes, not 1 byte.
> v2:
> * Use ol_flags instead of packet_type for Tx.
> * Added note about the use of unlikely().
> ---
>  drivers/net/vhost/rte_eth_vhost.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>

Thanks for the fix, it looks good to me:
Reviewed-by; Maxime Coquelin <maxime.coquelin@redhat.com>

Maxime

