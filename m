Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB098CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3377E4064F;
	Thu, 15 Oct 2026 13:27:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 90E89402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLOuJkfWWEN8MjSPZAGXMkr5lS2gtYcbiXyC/UsuGDQ=;
 b=HCNy2fjlRjuN3H0o6o7OzvCd6YNDhar6qLeLB30fMR6muISr1/gz1taKv+UFgWiK4ZShEZ
 ZaIiDyqtFKs7qcoYxyZJ9Ewdg2HbMNowexVPuBNysU1JnQIOI9y58Wqh7EbrC+KgxX6y2t
 3J0eIdtOGmQZyBOR96+cNMLAK2f8mpI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-jCWDQoerOQO3QEvUuHU_Wg-1; Thu, 15 Oct 2026 11:27:09 +0000
X-MC-Unique: jCWDQoerOQO3QEvUuHU_Wg-1
X-Mimecast-MFC-AGG-ID: jCWDQoerOQO3QEvUuHU_Wg_1792063628
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1ac6663e1so26510135e9.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 04:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792063628; x=1792668428;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZLOuJkfWWEN8MjSPZAGXMkr5lS2gtYcbiXyC/UsuGDQ=;
 b=S+7JTLpRKgEJPjiTRBc47w+o/8amkQvtNmN1RGoyPyA95ecuy+ts7VM42jcvcXJMSs
 AqIxHwV/7BKxB6pukOu+dWeNT5iOOmxnbqLTLXIEtj3S+fnxT0hZjE0+89q8wG0bUhyS
 iGN7ptRyUmWT1x4b97gXgVs8ZVkCu2nJHeGz1I4omctl6Vl//fGapn0xaBsUbbQ5x7EI
 BO4EKzbynYVKba28oW8PDNbsEu4VvZozTsa2IHDbWXENq4zUQh7gMrBbR0IF9p5zMCff
 o9kbAb0DGDnmESEge9KS4BGl3C6APNLF/2fyqecsqWJsdsfQwhCFR4BUrIDMXLbwHXF6
 R8Gg==
X-Gm-Message-State: AFq9FYIZxoqjpqoUZ1tre565cR/TiyLzE7PnhMgiQ6qMuVVMuVD1rmZN
 9eG6sqki3Q2lrJ6LPsOX/lIqOpabBdZs6eqBPNlu4R3mLW9UiWO5dFvDjYFHN9xdbVKQTLKG2aV
 pihk4HfrW9ewWAcq17C07FaylIzbIcpQQ348wqv+47/vJ
X-Gm-Gg: AYBFou0N8AvQSeQy+II+OXtXsaB/UYLbx6w8xJo44dSfqJGks+oNtLCnS8kCQrUmWmb
 EyQv4oS41WU7VZ2NKWxnWUIAi7hk+3fK3yUT+s3H/fDTNTxYWm7oeFNvnhnMWzC7qRS0lYqX7z3
 Zz6OGyeypaupO7BZfKrjWdnJmpmFQvbKt82RbmHswwuKwQ4xDPj0a2R5bQlM+F28E4hb4+hVFw4
 YqlPcZBYgnH9wkp+PHRLiho8wuIJ1bw4X2UO7fIjwNj5vIHjhhsMEuO0aMQ2OvHrpm4p9K9EpaH
 8jx9QHeQ72BARqAj4+EM0woaKQWkoKjEUXV+onZHpc66f3pwhAvvLU84kHHF9p1TMsbEw8U8ybC
 Mw1dSnVNf8qQUikk4uJb2MAAkCR+BihphCF6rPP3fGHIN6h7MEXuJ3DlG
X-Received: by 2002:a05:600c:8105:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a18e483818mr406353735e9.12.1792063627778; 
 Thu, 15 Oct 2026 04:27:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8105:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a18e483818mr406353125e9.12.1792063627301; 
 Thu, 15 Oct 2026 04:27:07 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd6834dasm58827815e9.4.2026.10.15.04.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 04:27:06 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 15 Oct 2026 13:27:06 +0200
Message-Id: <DM5DJCJL2UMS.C2JGDOMKQ6W1@redhat.com>
Subject: Re: [PATCH dpdk 0/2] Fix dynamic link of driver symbols with pkgconf
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <atCt9qNiM4l2x6hT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <atCt9qNiM4l2x6hT@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ixS2Fgw4vcEwFevCQcIefElBfD4OE4BlJl7eEKva2Lg_1792063628
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Bruce Richardson, Oct 15, 2026 at 12:41:
> While the changes in the two patches are ok, I don't see how they affect
> pkg-config. The first patch just renames a variable for clarity, and the
> second only affects applications linking using a meson subproject rather
> than a .pc file.

Indeed, I had forgotten about updating the correct variable. v2 should
be good.


--=20
Robin

# To order, call toll-free.

