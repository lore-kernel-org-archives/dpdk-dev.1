Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B8606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZsgHCeDL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F06F4060F;
	Thu,  5 Nov 2026 16:11:17 +0100 (CET)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 211EB402DB
 for <dev@dpdk.org>; Thu,  5 Nov 2026 16:11:16 +0100 (CET)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-67bf27f179aso2035223d50.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 07:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793891475; cv=none;
 d=google.com; s=arc-20260327;
 b=SPDd0yJ6JDlpbUHu/u47rDCQqfx/TtxxIeI/5mul4PaZ7eFQZe3TaPN+DEnNUfxeqF
 BSa9SKKgp97PNwaqTD6vrmFvK6wF8UbkaAf99TtN6XC5pQjCHEnRhDOoqLu5u9dODZ2T
 KMKEw3IiPjRKEsX7VThtQAp5KomZTP3w9Djzp87I3RgMPs3udID+0fwoc5ccjxrnK/OB
 XewkUQvOWY3EvlFpGD7dxv46Vpvx3qaKfOTfE5m7a3tDaon0NRARW6le4QcDkFmoM3SP
 zBX2MOpXoIKOPbz/MAmS/nagT+3e6II/JClRXUNkpZ4B+CJ3ZeoMtEvZtQjq+RLbj2f5
 bmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L6vraU6KSuYuSgF/q7RKCL+nfEuvnEXTsnnt41BmioY=;
 fh=oBzMBBXUrXJu8DCdXy429mcmyPngsflSehz1sgIePJU=;
 b=gXiuXzcIEWVpxdiOMPbQYu8YHARl4XPpkdQRn2N4Bn+MgStIsoego6k0nRJ+kiIxwC
 UaEooeZwuhpApTiE6Pca1AQmvKnZnHSIs896rDY7o5og/Lp6LU6bc7CKkqPwok/7uf2w
 jZA+uH/uBjKRca3vpnXJfV2LMvdbLlDbrfw/E2c9UEH/SrMlzombRdq7hgUH5aVSZEsJ
 s/tHc6+/fFgIh7s6Siq2xF8m0WS1GYZ9fa12R7t84aHuCEWc5jIh3lcAqmU4M9iddatB
 gvHSR0W117aYYJ7h4SYbsizP+ZuLG8eRAZqv+sCE540A7DPLXqJVK61sVuhgeL2JbMtE
 l33A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793891475; x=1794496275; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L6vraU6KSuYuSgF/q7RKCL+nfEuvnEXTsnnt41BmioY=;
 b=ZsgHCeDL4BSTCtvVEkjlIi+9vgvUi0mI6XjfA7ZPJuz69/WJLWQwhdqcCistKj5B8V
 W2n//BIbZeU0R1RTSdfYoQy3AnBipPcKL18OKkCAJFb4RKWBVy8PPRAvx+Q146/fEXfj
 CzrsFGueMSoaRRDLc75M04F1jlwrMFEH5ndQDtvyiLsIaL1LEgm7+fRcTE+4nwDS/eF2
 qtyPO787JFKgMRQXS8tMFCjB/mIKqlqCTBiqLm0Uiw2Ut17YgCg1AbvqMXq2UrJfplwp
 g+yS4y2PmV3fhxJWTha7hPMh7oJkbG6KZWfCjvuLOfGR46v4ZaJREDSQwqoWsti1Jq47
 94CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793891475; x=1794496275;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6vraU6KSuYuSgF/q7RKCL+nfEuvnEXTsnnt41BmioY=;
 b=H2uHP/0Bj4guYgeH9pcbnhQ/AAOwdOh8mTkPTuSI0L2nX2IetUPSMW0qAK+qcRMwku
 suB4y8UxglvxfvHCbLeD6/xR5TFhPucLWV4mkTKbqAmI8bO5Xqs9nib+AnwVk55C/JSh
 fE2pQVjjrTRalkiWYfsqs1kEPXGxQz/osAAjTxSUZAfFK3pQlsmXv+Fnbfr78vmB7NVu
 pADUUePI1+nRVSdzDTC6zI8l5kqPxSV3DBfBwxgueWH+cAa8a3ebGWkeRhgQhIyBysdl
 yJlknXZ9caNS3Yf5ylvXFLKh/zjw0dsy4Zn/4AhPCAUuEfuoKwL2x9uRSr05qvuL8Zer
 3ejg==
X-Gm-Message-State: APuU4Z/CIZleR3xvOIkVYlrK4rXVQhIj1SGyTmvwd0N8NzTWBp5rxwQU
 wSywWOTbIUCiTg9eO9DOA0HunJGJOVT1DgTmadU9c3w1WinBrKWXypeVLJsmmUuYN/BgnnV3v8W
 atlpiZTYVIqwS35KgMEKQ9Hul288hwBc=
X-Gm-Gg: AYBFou1auNpEqkeEpI7wX1B2Y/+6IPn9gKIe+VCQUcXxEpvkHnqhS42Vius/T1KF9Jr
 AqEpSLlUuIEPOBVQ8W58/u+9xgrpmd3zk5AErqxnZ0CS5Q1B8HfkEGOgMXnuqTGEVCLZDnmcuYi
 HjOc1oB1tir3fF8QLPhRVdOT8TB2oFz1W3jNeluykMv57tYx9qnY2p9ST/wyxOsJbYx2k4t9TdR
 73L4BfstA+cLGOA9hNgOQOkJrvZKxKC+uBhspLPxBfUTaa0vgKaJRSqwn/bRXLTtcrWZdf6lml9
 IZz90cSFpE/P1uzNFFS/E4+KkFZNhVWr40MZzGzCOQe6hqBRoTjVxuDpgf9VaAaNmE7VrYPLnWm
 ggzITxJbbr6cS1AtAVmzZ0ZKPAdR8xN7tQXG12/NhOA8E/Hq9xxong9FbL8UIe2qy0QQckOQPLz
 FmFIGVcV8saWfBEcIgnN3KpUdZYuT3jlZgjB9iyIazJFgUOn3WHfszvC7zAhYzavotAqbV7e4re
 I3JG7rmhfv5nUv2lawDh+Q=
X-Received: by 2002:a05:690e:1182:b0:67b:e0d8:b1c4 with SMTP id
 956f58d0204a3-67be0d8bbe6mr2811272d50.131.1793891474730; Thu, 05 Nov 2026
 07:11:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030063915.1016749-1-nkishor@marvell.com>
In-Reply-To: <20261030063915.1016749-1-nkishor@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 5 Nov 2026 20:40:48 +0530
X-Gm-Features: AclHuK9hH0FPvd9Lihu-y7dkFYPuIb5OrCqKUHRKYUtc8MLL2yfsKHrvBxGtmfg
Message-ID: <CALBAE1P1mzDmK8QDkV3v6QQ1rDhYn7wYB1bv2PdKzTc6nkT5hQ@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: disable flow control on pool destroy
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, asekhar@marvell.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 12:28=E2=80=AFPM Nawal Kishor <nkishor@marvell.com>=
 wrote:
>
> Disable flow control by clearing fc_ena together with ena in the
> pool and aura contexts in npa_aura_pool_fini().
>
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
> ---
>  drivers/common/cnxk/roc_npa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.=
c
> index 5075067cbd..425bbc782b 100644
> --- a/drivers/common/cnxk/roc_npa.c
> +++ b/drivers/common/cnxk/roc_npa.c
> @@ -366,6 +366,8 @@ npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_=
id, uint64_t aura_handle)
>         pool_req->op =3D NPA_AQ_INSTOP_WRITE;
>         pool_req->pool.ena =3D 0;
>         pool_req->pool_mask.ena =3D ~pool_req->pool_mask.ena;
> +       pool_req->pool.fc_ena =3D 0;
> +       pool_req->pool_mask.fc_ena =3D ~pool_req->pool_mask.fc_ena;
>
>         if (roc_model_is_cn20k()) {
>                 struct npa_cn20k_aq_enq_req *aura_req_cn20k;
> @@ -381,6 +383,8 @@ npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_=
id, uint64_t aura_handle)
>         aura_req->op =3D NPA_AQ_INSTOP_WRITE;
>         aura_req->aura.ena =3D 0;
>         aura_req->aura_mask.ena =3D ~aura_req->aura_mask.ena;
> +       aura_req->aura.fc_ena =3D 0;
> +       aura_req->aura_mask.fc_ena =3D ~aura_req->aura_mask.fc_ena;
>         if (roc_model_is_cn20k()) {
>                 __io struct npa_cn20k_aura_s *aura_cn20k, *aura_mask_cn20=
k;
>
> --
> 2.48.1
>
