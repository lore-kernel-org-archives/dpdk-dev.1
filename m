Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AB606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVpTYdcr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAC0740E64;
	Tue, 10 Nov 2026 15:58:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 4F70E40285
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794322699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPlpTWWgd++halKDo1j5FGSSkSkZuVwtKbDrCHUJJOk=;
 b=fVpTYdcrpt1K0p4b1gz9IEeeyqYawuq67wXDtpiwXhBtYfvsgUiXKwbvddTqFCKadB/nlh
 x3D/Nm2FBmeHLUajXu8FLbdvFyzOGSvWbcsYrCWpLYgamgEKTbrGfm8ovb+I1mrhSSDk64
 b0GNFJmxWzzgn+GmXqsYnJ/wtPCR5Ko=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-vefL6_qTPc2-KZVbzN-rWg-1; Tue, 10 Nov 2026 09:58:17 -0500
X-MC-Unique: vefL6_qTPc2-KZVbzN-rWg-1
X-Mimecast-MFC-AGG-ID: vefL6_qTPc2-KZVbzN-rWg_1794322697
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so570830eec.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 06:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322696; x=1794927496;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XPlpTWWgd++halKDo1j5FGSSkSkZuVwtKbDrCHUJJOk=;
 b=jtt/LrAGLIAWtN5Ohjd+gx8ziyZ+cS3v6kd0ZF/cBa1XJBb0PPssj0ai0m1lLuRgVA
 TK9md+qSpcCYUI5ahsdUdumrbxwnkUvyQRVWf8gfIoEINvFoelsZWlHM01So1E/ExSOX
 NeFPAkoy/Ac5NMtB/XUIlUjUXA9s/GtonEj1mClh6zVRt3bU5I9CxnvYViz7MGoUGd7z
 u93n7jbkCOhGzO4pmU9LuMWRLRXepE4ohxnt+P9m57RnEdqfXPRcU9mXlMQvyE0nGrwE
 83ytdn8tyXXPglQLzdQCN9HOkKBrkzUpvjkq8tpYeGDr0cT4T1P2BRul1UOUTkDGp5tc
 +Crw==
X-Forwarded-Encrypted: i=1;
 AL+hErHz/mum/gaymcKV4H8cTPFJvtdmIDyPTPUmwJoE4rGAVByx/Jf1LcnGTZvYR/qg6CVBIlA=@dpdk.org
X-Gm-Message-State: APuU4Z9zHlmPK53zDTwMNGtjoZZPqzbhYtADviRbEi+GdtGtFI5hp5wv
 II9WaNEukisYJrA5cC8NHMdvWMaFLRvSpOktQDe/mh1DwAiVAqUpufef67+phehT1WecRUFQMpI
 p9q+MNZQa95b/+KQKrQagvZ7GUo5fAexjhfzDh/dPGTgAKjGEIfdwjAldPcQ2Xtvmp+19AFdeKQ
 HH9svIO5FZt9I0EyiTS5A=
X-Gm-Gg: AYBFou2pkyd9WRthqLs1SO96gXFQbr4ZbEql6DwsKacdad0+aKPx4rLgvzo3TWPpGWu
 SzTsNr6m2OwZY0J5DKizTEQRz2oEim9tHifw8x8NP/A/2sUC8XZN0CEg4iiOMezNMHzObQTzEWH
 7mP9x8rHbLCeGiO8xgh6jj08zx5rOZq9FDHQO71Qs6DUUJO23h1A0MW/vBsD4eMud3eBoXc+75V
 RuI9u2G++8Vqqsk/9ATxqRtdENMEnj1y9PcAOiWgLM5MmwyVcdr7zQzE1johefLv3/jOlBxiZAC
 M/ITT64jxmKQnvUjS6GwUIs8kk3QndHTpM7Fgt7EnJI=
X-Received: by 2002:a05:7022:5f19:b0:144:eaa7:2763 with SMTP id
 a92af1059eb24-1b3b60001f1mr3655096c88.16.1794322696290; 
 Tue, 10 Nov 2026 06:58:16 -0800 (PST)
X-Received: by 2002:a05:7022:5f19:b0:144:eaa7:2763 with SMTP id
 a92af1059eb24-1b3b60001f1mr3655063c88.16.1794322695676; Tue, 10 Nov 2026
 06:58:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025081639.2746665-1-mkashani@nvidia.com>
In-Reply-To: <20261025081639.2746665-1-mkashani@nvidia.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 10 Nov 2026 15:58:04 +0100
X-Gm-Features: AclHuK_zMO3CGdPm9T7sO79PC_IbD2JW2AJ5hj-oStxjliKRNM-J-OS9LOvLN8s
Message-ID: <CAO55csz_1mrKh_RN7ppPESS7YkvSORVzAAiTzrT7-EqLP8dmHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: fix RSS flow leak on steering update
 failure
To: Maayan Kashani <mkashani@nvidia.com>
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: myCOYE8dIh1NI9IyUbYcBPpCqnebE692LgwRMC6MBU0_1794322697
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 9:17=E2=80=AFAM Maayan Kashani <mkashani@nvidia.com=
> wrote:
>
> mlx5_vdpa_steer_update() calls mlx5_vdpa_rss_flows_create() which, on
> failure, leaves behind any RSS steering objects (matcher, TIR, TIR
> action, flow) it managed to create before the error, relying on the
> caller to release them.
>
> mlx5_vdpa_steer_setup() honors that contract by calling
> mlx5_vdpa_steer_unset() on its error path, but mlx5_vdpa_virtq_enable()
> only logs a warning and continues when mlx5_vdpa_steer_update() fails.
> As a result, every failed steering update triggered from the virtq
> enable/disable path leaks the partially created software-steering
> objects. Over many reconfiguration cycles this exhausts the kernel
> software-steering (DR) resources and later probes fail with
> "Failed to create Rx domain".
>
> Free the partial RSS flows in mlx5_vdpa_steer_update() itself so that
> all callers are covered regardless of how they handle the return value.
> mlx5_vdpa_rss_flows_destroy() checks each object for NULL, so the
> subsequent steer_unset() on the steer_setup() error path stays a safe
> no-op.
>
> Fixes: 9f09b1ca15c5 ("vdpa/mlx5: recreate a virtq becoming enabled")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/vdpa/mlx5/mlx5_vdpa_steer.c | 1 +
>  1 file changed, 1 insertion(+)
>

Applied to next-virtio/for-next-net.

Thanks,
Maxime

