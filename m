Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A94C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 087D04065F;
	Thu,  6 Mar 2025 14:48:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 350E740430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741268928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgMl/fMXidebCZ9xY6t26jR5byrgHKCBLy5xEI2Ma8Y=;
 b=jF6MFQikUD0ETX/TZrIKj4bRCCs9xqWyoCnljlYJcpfIUdl24sqZjwxcpeG1unNZVnlcJw
 JhXa2btwgOfbw8aKP9ZR9OFLkvVtIi59oeczKa8A8s1nDOfElDAcz1tMK0JpIMz0LXK8rv
 NrUOzJ3CBRoGt/bvtQoNtOIKW0QlxGc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-vFMRf4N5O4WGj_D1Mz7Hng-1; Thu, 06 Mar 2025 08:48:42 -0500
X-MC-Unique: vFMRf4N5O4WGj_D1Mz7Hng-1
X-Mimecast-MFC-AGG-ID: vFMRf4N5O4WGj_D1Mz7Hng_1741268921
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30b9914aba5so3474751fa.2
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741268921; x=1741873721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgMl/fMXidebCZ9xY6t26jR5byrgHKCBLy5xEI2Ma8Y=;
 b=XKK85i6NkTyIqhnKHdsGVI58iXV83vB3/9gsZVmZ7FaD3VTRru4hrqsLtny+G8eXUp
 QuYJUEMzVb+HnvCJswIWw8JwXBT0f47H/a8FeyeEksznZTGs4uBoK4jIiJ5wmRElRR23
 yT3ueLBUJKPhMJXYtNHvYlaQ4rYmPzPAZAGVEc8Qw4X+GYiXfNQBO8AI9F9s20KiAfA5
 6iV37gWnhxRsA0gJkS/fynvmYo/GWWWHnfq3ccgJeSA3dehM/OO28FBxIqINV09Q5oSN
 0iXfKu3TOmFJo+gvMxQl0Z2X6j0U+MofwRU0gL2/hCqJ0ujLP82Joi9XD7AHtIzNztjU
 /vKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4FTA5p/xPO3UzFK9h9HI60x1IMmKmYwwNPlJGIPQRe+CBqWZ0O56/lA+8fqJkd4pr2+4=@dpdk.org
X-Gm-Message-State: AOJu0YwPnr13B9YVbtJ6oSWNu9RL/64Q4wtvS6tWPWLB7BQw+xUSj4kg
 5JxZow7EeD3n/h+3aY31Lud5uOvcYg/dwAHMkUaxnTJ1Yvvrn/nbNSQdsk6d/tHCJ2R1slh4rxx
 Gcd9GrzFpHtrsePk5EMyKpIohNM+KRB3AJeZ7L6jJNCNkDwJNPGBN+nGlR7VT+Gs2LBNG4lO6Ju
 k/5GWwFIIgs9VgMwE=
X-Gm-Gg: ASbGncu5ZtWg70xMsUsDs+ErwYK0z2OJxeDJ+TGkL1Kgz+Bssdwy6pV+fESSxOge8k1
 YO/fIfRwP8Jj5qZY6mCPqL9yWX2CZJUaB5djPxWG8QepXTHggFe0vK0fG3FU3bKGpPgvcoIXOjX
 4=
X-Received: by 2002:a05:651c:2125:b0:30b:cceb:1e71 with SMTP id
 38308e7fff4ca-30bd7a272bemr24576891fa.9.1741268921363; 
 Thu, 06 Mar 2025 05:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGW4inuR3yASPdH0ryDoIA9IPIXnBqvm25Zyhh5Vpq8vvSkQ1VfP5eTmHGFK+GjbWFi5DlANhhEhQUR0Nlleo=
X-Received: by 2002:a05:651c:2125:b0:30b:cceb:1e71 with SMTP id
 38308e7fff4ca-30bd7a272bemr24576801fa.9.1741268920982; Thu, 06 Mar 2025
 05:48:40 -0800 (PST)
MIME-Version: 1.0
References: <1740768356-29954-1-git-send-email-andremue@linux.microsoft.com>
 <1741033501-9318-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741033501-9318-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:48:29 +0100
X-Gm-Features: AQ5f1JrfcqVjdRjkAeD5xSHsxn5WfpQhlhY6U81Y6QdM0cdHfvjNsCkZ4qycqQw
Message-ID: <CAJFAV8zTZbaAsFf3AeafVRuJT6JUtpk7M9KpXRMhv9Ux6P7Fxg@mail.gmail.com>
Subject: Re: [PATCH v2] acl: use common top-level variable for easier
 maintenance
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, konstantin.v.ananyev@yandex.ru
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MZVYSOVR7vzGsBokuhqSzNrMOo-Y4tSJy_qMW3hAc0I_1741268921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 3, 2025 at 9:25=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Updated meson.build to use common variables cc_has_avx512 and
> cc_avx512_flags.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


--=20
David Marchand

