Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFCFCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:35:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39B5940693;
	Mon,  8 Jun 2026 18:35:29 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 8EC43402DD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:35:27 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8ce9e56f68cso38206536d6.2
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936527; cv=none;
 d=google.com; s=arc-20240605;
 b=lWLgt/eiXqeJTByLhrr4jT6meE5IYQOJbgHqut0sL7sVdaC9P3ZMNVmmHzhAJA6OfL
 fPjvZV2Kd7nt82SSXUfNQ8UJCS0gY2PPTrZFHPZZKomnKbmYuJ8aUO+H5RJNj+JC6xgI
 rAmm2G2BjgnVkK+8p7/FzYoC+p7SL6R0wlQq1Q+Vv3ewgqlXWiWRVEMX9g0FYr+Rim6p
 3Y+eCNKrjJbbr8wFZs9swmjmhe7hj/pMcuZLk5Qm5Xme1UY/j6IuMyyf2TxUGLnb0dLJ
 VnA5ZV3cU9GygZimqdquqvFLUuXuHG6jSyP8KLrwbIJiwbDQziVuwXdDOLzJ0q4jDIFf
 Wn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IV79q2fSXgQm93OjsiYuG7W3ZepLsk5g5u20ofk+z9c=;
 fh=HzlbzPms0lzHAykOJAPcX2CohHz/VUZhF6rINnzG4vs=;
 b=Nna45E9qEqCSC7CTDaxPUi4fJGoOnlSUld5fwXEhXDfbCWCay4KnyB4Gc8p9RnCy+O
 jm/IlfUfy6vOZTQdCgjCv2GNL+yhXt4gG+29iBr4Svkl4wrke39z7JMjyAnpixA1yHNe
 dZHB3AV9skwFZP/ikaKpaFpUgKxAn6qjgkLkZK56dOtlFcQFiUc47M5sfsIZBpun7hSK
 ZdZG2MrKXt818QXSo8CtXWlHRqKdNIW+4wq8OtN6dj3cM7yp/oGvIalRQUn5LU2b6pQ2
 XZ5MDS/lq1QSy0LfN2qQkg0sihEUmE6iEBvpZxtrJZKxJjMM+k7DqRTNYODyFoL8cTqe
 s7vw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780936527; x=1781541327; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IV79q2fSXgQm93OjsiYuG7W3ZepLsk5g5u20ofk+z9c=;
 b=ANb+Apimq1Xlr4wZ+7CBBa1skP0N1jHInMSkNevvPafRiocqs+TBek0kE5hsrVgt+v
 tkIzN8wz+K9x0CrPw8vhkgDpIYWIs4rKgwi5HrSDrPvBSMSQyUu+16WdecTUfsKDGv81
 ycfSKdMMxZ3ySg+AcakS3FD7zC/EnL87fJoCK902YQQ13eJflMz8Z7BMtkt5T102xGIH
 OsFO88YW7tnupBxMHG2n8hfi3AJhgNp0h3jcoNOlbhBSuAgoUg+ie+wlRot822CLXYSa
 lQfJv3+eEW922JeUsSywT3ocDg/gvaD1bbJQ3HsONYlGR4k7Ep4CL4E9UX5G01Pn5p7R
 aBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936527; x=1781541327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IV79q2fSXgQm93OjsiYuG7W3ZepLsk5g5u20ofk+z9c=;
 b=CDhanoJUeCG1y7PJixm9BZLoAe/HY7BcE2HEe+uiUg1Zut/O4pjm7f6ItV0tEP/RC0
 Wfq11GSlcNCpYymAp1rHBCwhJDTfqjMHoTMdEfeA5hx6yceOtR3tNEypna1EdlgL/gtc
 L+wQPv8mgY2oVTqCgQN9IiEJPROb4/NGZDXsHCJN8I/bpjrBzyRDzQgPvIEYHMRg0L8S
 draIiaF8VyyUksOzIf7hAqUWPj93bu4Jno0o16fnPZrqAj7IrZqGRyGh5di1p6IbgWaq
 KnUwXAHPPEYGUT6cAKIwawPbjbsXAUmTv4NQtYUaUw7J2F0HP8s2n2A6lToY52Fzre7m
 VHCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OEjcFRqi9zRBHCaBWL77e0N53bcNDi1oSwq9Zu9IzNcyFG8THiTcKct/7GABbMOybw8k=@dpdk.org
X-Gm-Message-State: AOJu0YxaUUZnBFK9rgxQ1sUoA77+ujCSKRkwBOECVmCSS+5u4pOgY+fH
 FrRtIslAYqnvz8dXHGE0o02bZ/RS4h/T4POEYmYQm/6v/t7NEx/MeDB2hPV7alnPOe6Sp02sj/e
 8zeJuT5KOyWJvT7Juci8j3L19S4P4WEM=
X-Gm-Gg: Acq92OF5RFg6kx7ZwYN5GpXhxPird6GQmabFlW6O1bMOv0+d4hGpvKbYAKoJT8bFsew
 qgalrG1Pz4IHsoRNukk4ZUTdUPmZRNgDHgUn43yYlSBHuBMXVqyEF/o4ZU2S6q9e2nH9SGHvUvX
 7qnyc7GTJXG6pyOcRMZxZcsZQdsPogqyKQdevOUdHa8J7hPY7018W0Wz8m7LUkGH060KM+rNdIH
 4qPGfXwiHW/m2GScVnWHQ1L1X12aB3CVf/l8T6KGLQjf+nWrjORA2oViWU0Y6fwKHus+sgA0wyU
 Nkw6y8Ct6rfXDQ==
X-Received: by 2002:a05:622a:586:b0:50d:863d:b50e with SMTP id
 d75a77b69052e-51795a877aemr239207031cf.3.1780936526637; Mon, 08 Jun 2026
 09:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260521082647.71442-1-pbhagavatula@marvell.com>
In-Reply-To: <20260521082647.71442-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 22:05:00 +0530
X-Gm-Features: AVVi8CcRmFc5mnyC41I9T_uyw7vPVT8RWSXPB6A2Ddv41njXloxJmNPwFneodtM
Message-ID: <CALBAE1OBK+MtBwyuBqkq78816ePJDERm4dffzeyFsBXQf=AtYA@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix VFIO MSI-X interrupt setup
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Tejasree Kondoj <ktejasree@marvell.com>, dev@dpdk.org, stable@dpdk.org
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

On Thu, May 21, 2026 at 2:25=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Use heap allocation sized by the configured maximum interrupt count for t=
he
> VFIO irq_set buffer, correct handling when irq.count is zero, and use a
> minimal stack buffer for per-vector configuration.
>
> Fixes: 1fb9f4ab14b3 ("common/cnxk: remove VLA in interrupt configuration"=
)
> Cc: stable@dpdk.org
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>



Series applied to dpdk-next-net-mrvl/for-main. Thanks
