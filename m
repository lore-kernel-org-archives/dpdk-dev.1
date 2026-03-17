Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC6FED9E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3600402B0;
	Tue, 17 Mar 2026 16:45:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7DD1540270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 16:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773762342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74eHfaSjVJvqwBQbvEk6/1FTzfDOlCwbIwffAFWn4jE=;
 b=T3AQd6nCxb548kCn5V2qsNTMitFEHkgNzKjCr3aRAXpyriQxoxJwHDnbUFZ5vi5f6gBI0s
 oQoj/2TwbtmZ+XZqXakitFvYomLIqr68Aaj1Ii+8B1plBrVmqdGDbYkGE3kT/sVm3G+uzn
 drjc4WR/0SnpXgwnZTLmjlszIjwfQFs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-CPvpw4QpOfSbt7nHmC_FEw-1; Tue, 17 Mar 2026 11:45:41 -0400
X-MC-Unique: CPvpw4QpOfSbt7nHmC_FEw-1
X-Mimecast-MFC-AGG-ID: CPvpw4QpOfSbt7nHmC_FEw_1773762340
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a27868e512so269018e87.2
 for <dev@dpdk.org>; Tue, 17 Mar 2026 08:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773762339; x=1774367139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74eHfaSjVJvqwBQbvEk6/1FTzfDOlCwbIwffAFWn4jE=;
 b=nb6eWXSRXStYwspYPr0toDm0VuiPZLPPE6wPrGQP9migsTy4rpEu+D4WkXSFt28rPh
 ywi39XNoF5cB8uDL0Um+r6QMT4MR/fJeuBzf4PLrEkAOtEU/t82xe1n+cbgjljFru+SU
 bz5N9xCMhhAEEMM3PSVDEF82NQfLU8A8ATPSyFx1KiXmZN6Ioy3+6VJQ3+4+HjGRdMkK
 X594cOjR1OfhqOdB+f7VenROm5Z2hF5zepTgIBtxWGOf/N3SsG0upsBRAHOMQDA7Qfb9
 zw412G1fafObhUWIvX7FhtPzOLqvbYVBJJfke8f3abQmsItRJXNhiW2sfXENdF0kje/9
 9s7Q==
X-Gm-Message-State: AOJu0YzzoX6yy+FIU5s11UgpzLniSeNUq92d8rGzc7DuD8ZrhXR+Fa84
 BOZcrIdJ4BysfrKEiaKUJy95on8EgMXs/5FqM0HwLJzHQhYuTdIjCYCbrRup0ocQqmvXr1Tfxur
 jAPfHZmsanb4QCbAeZlcQXHyEYviXS3bCobf5SZKLwzSHxLRIsD1wqMuEBqktXZ8zdvKXxQYxHF
 oK+MsDKlqLQgLAF/Rd6UA=
X-Gm-Gg: ATEYQzw3LxrMhcCn0Surf7q5svzS+w3o1yvt4HTD06yqMtKevgp/o6HK4oI+DkoAsRS
 jhd05S6d/pjdkoDMKMpdTzI4AUR/liuYDJoEhosx9Qhp4RMBJ2/sqDSw0rsOwM/NKU+AIZ34iwr
 E8I0vut/sEqAjSW4TUPYymVCqUwVKFWzqzm8Gbc1oNNGipT4doS6ZFtwGmJEZWiORSekoKaBnQC
 lZ0g3shMjRiAsMjmIMZc7vUC2nJMNS2OeMNSM1NVsyLy9xLdjqvhPIupqRHUUShRhZzHQ==
X-Received: by 2002:a05:6512:39ce:b0:5a1:2f9e:ec8f with SMTP id
 2adb3069b0e04-5a27958543emr23473e87.10.1773762339421; 
 Tue, 17 Mar 2026 08:45:39 -0700 (PDT)
X-Received: by 2002:a05:6512:39ce:b0:5a1:2f9e:ec8f with SMTP id
 2adb3069b0e04-5a27958543emr23454e87.10.1773762338928; Tue, 17 Mar 2026
 08:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260305105016.1093351-1-alialnu@nvidia.com>
 <20260309150856.521907-1-alialnu@nvidia.com>
In-Reply-To: <20260309150856.521907-1-alialnu@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 17 Mar 2026 16:45:27 +0100
X-Gm-Features: AaiRm52SJwfdWeQoBlk-CdMkE1siQoengC9cKHU555Dz-4J8LsQH18IFbcF7gs4
Message-ID: <CAJFAV8wSy0oudvk25HqtspeaSDKyCQLd-XofUVb-vt=dhvfQmw@mail.gmail.com>
Subject: Re: [PATCH v3] devtools: fix symbol change check for non-lib patches
To: Ali Alnubani <alialnu@nvidia.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tbCRhLNdITueHoDJYCSs4VoqAGWEUFyK2TOCp7EhDkQ_1773762340
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 9 Mar 2026 at 16:10, Ali Alnubani <alialnu@nvidia.com> wrote:
>
> Handle patches that do not touch lib/drivers (e.g. doc-only) without
> crashing. Treat every file header (--- a/ or +++ b/) as the start of a
> new file: if the path is under lib/ or drivers/, set lib and process
> symbol lines; otherwise set lib to None and ignore lines until the next
> file. This avoids both NameError exceptions and misattributing
> export-like lines from doc (or other) files to the previous lib when
> file order varies.
>
> Fixes: 1a0c104a7fa9 ("build: generate symbol maps")
>
> Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
Reviewed-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

