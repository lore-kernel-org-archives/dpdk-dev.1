Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D106087A38
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irdmVZMw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0E3840E1F;
	Mon,  2 Nov 2026 16:32:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 0520F40274
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:32:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793633548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxrPmGlLxhAFPYPmqp9xN7CTW9rZme5wa1cUfm7nR3w=;
 b=irdmVZMwYiXZYyXVFyzhWJ81QMv1tWPT5hBu49p/bCfXhpT1euxhrcwAh46GmdF98ZVvVI
 pCu84EgsWD0+6vyZzrUyVhGN+xrwfbkzfuF4qpzytHU3l6J2XGf2/QHrlKjgZywLPAldzI
 AuT2MggCkhMzL9DzVQVdz9iCIjzY7pk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-RfpoYwPCPU2C0tsXhNBCOQ-1; Mon, 02 Nov 2026 10:32:26 -0500
X-MC-Unique: RfpoYwPCPU2C0tsXhNBCOQ-1
X-Mimecast-MFC-AGG-ID: RfpoYwPCPU2C0tsXhNBCOQ_1793633545
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a58fef21b3so18673691fa.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 07:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793633545; x=1794238345;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AxrPmGlLxhAFPYPmqp9xN7CTW9rZme5wa1cUfm7nR3w=;
 b=BCRmEPov8LidZgMAPa5+02tEi89Kp9q5+I+rSmBPSXUD/PFiBqgFceugeJ8tM1GjEm
 +bDukEMas3ZVmMbUpcLgQKDJbgu8htZtId6vzziCZwsUtZrCD/DPejJW4v6IrYSLf9/x
 UbRNgUrMgtmKxmzwEtKbU6wnl7mLHgJw0aUz1StKSeEDn+DPnFDLsHswy2DADzU2iiQ3
 +Ml3GaGzlWJ0sSMANoI8Dkg+WB5GixYq96dJ68oWGmM/hciuShGVuNeSp3CG9L5uJmt5
 uBLU1CHLt83eM5zkXdNSzfkiV6TaXT+fr4M+pdKoHmsN57QFsTXqaDjM17FK1/gIRp5K
 XgpQ==
X-Gm-Message-State: APuU4Z8UpPfCREtpHFQeIghF5GK37LxDa8VUb6pGznnh+tT9NoEiKaAL
 3wqF6xo7LfBhV1skaPfyJIBn3mkzCGhj40CwZe0DgRbcmyFZpAzkO8vEOU55OKhuhS6fuPNr/pV
 PHn11OwrcyVKCPs6qUHx7pcjBrE5753TeetTbGkv4bz7zk33BI5zyHEIjqXq4Mq9q/8cD087Iwu
 bASe1Ruh0tZ4dDzotW0gc=
X-Gm-Gg: AYBFou3F89A8wkXUlxFlTOuQC6c2GG2wvbAq0fjjNtycjUVXswYaG5RokGWKRuxX9Bc
 xcLoGp3jlXirfVvAdlZWdQHmcxYAscr22KCX9geg7+eA831aiVfbo13WD92CBPsEoeYXu4lhGX2
 nxIEIVeL07HaQhGU0q5IyiHPmlis7W5uo+QgJ/KmVfDhcHGVuST0LXtPPi7+MzoOvBo4kNZAnZD
 GcrmOkmC50slaowUN2128bHbwY0glNH6eGRd/ntotl9I/9k
X-Received: by 2002:a2e:b8cf:0:b0:3a3:5a01:a794 with SMTP id
 38308e7fff4ca-3acb796463amr25120531fa.1.1793633545106; 
 Mon, 02 Nov 2026 07:32:25 -0800 (PST)
X-Received: by 2002:a2e:b8cf:0:b0:3a3:5a01:a794 with SMTP id
 38308e7fff4ca-3acb796463amr25120441fa.1.1793633544700; Mon, 02 Nov 2026
 07:32:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102152805.644416-1-thomas@monjalon.net>
In-Reply-To: <20261102152805.644416-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 2 Nov 2026 16:32:12 +0100
X-Gm-Features: AclHuK8v0oqXwbfpu7_NbhthKAjqm9SrIZg-flzOMdFmB0kL-cQr2jWb9IpRHdQ
Message-ID: <CAJFAV8zH95879-fK3U9Z7pT+URDwty0O6yDV+a9aF6c2xx0q6Q@mail.gmail.com>
Subject: Re: [PATCH] vfio: fix cdev build with old Linux headers
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: culRYOmeyZu1jGrzVzZ8CIZyiYoKsa4nOXcEPbTbBGE_1793633545
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 16:28, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> System headers may indirectly include linux/stddef.h
> before the imported UAPI headers.
> Both versions share the _LINUX_STDDEF_H include guard,
> so the imported header is then skipped.
>
> If the system header lacks __counted_by,
> its fallback definition in the imported header is not processed,
> causing a compilation failure in vfio.h:
>
> In file included from lib/eal/linux/eal_vfio_cdev.c:14:
> kernel/linux/uapi/linux/vfio.h:1524:51: error:
> expected ':', ',', ';', '}' or '__attribute__' before '__counted_by'
>
> Include the imported UAPI headers before the system headers
> so their compatibility definitions are available.
>
> Fixes: d129414711aa ("vfio: introduce cdev mode")
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Strange we did not hit it earlier, but the fix lgtm.
I though I had fixed such issues.. but I probably missed (messed?) the
new cdev file.

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

