Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D5ECAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48D50402F1;
	Wed, 24 Sep 2025 17:27:47 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2114025A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:27:45 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4b38d4de61aso81524031cf.0
 for <dev@dpdk.org>; Wed, 24 Sep 2025 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758727664;
 x=1759332464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mxa4E7Wwig6jqdxo+AVbffupH3jtKfLPSjhg4Dzmr78=;
 b=CsLxidHvuoLZVxsb3sEUpnMWRzGPEeGslvL+xeVtINihFB531NPHEhYpd6x/hA1b2L
 wGe9/UK5VtUrR5bbZxgGhzfV9Uv78X7qG+T/jufGvDSPcc1kgOXEjzp1EC2n2n2OcE4K
 lEbFIrM9a5jv0OIy9GT8CPkD7kbn5W6fft1viu4OwefcYO70HLXNSGVpsKueKD2yKpQd
 Qdfl1tcP/wC2kNU1DQv2FEmPjFcdG9d9pZYdTrPDPNUGvVw/Ygc86bqJzrnX88Z2w2YH
 B83f39R5xGJia/qEjddtHFgqgQJHtT71djHisvdBJ6Su1G4TvQkNxZTEYv6pgX6sDVrw
 t54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758727664; x=1759332464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mxa4E7Wwig6jqdxo+AVbffupH3jtKfLPSjhg4Dzmr78=;
 b=mhXoESSIHFr8DQGQbQZKnib6klLQBI3YTMEePdS+gQBuIEh4MBXIxd+XkXbywIsmUm
 Birj1T9k6vU+RJPmpSaGDi13wmulEPvEYRm+zp/hzwaUMBxYNlfpg+RrrA/Zfp7tOZN1
 5KrDMZBA2VbYB5oNHLMUQvbuzcspjqz/6RQNP58CgGLhU+gry3D28EzWrRZow86eWFWA
 MAQKdsRXle5oxzp3Ga+qMkQ2qMb5yxTsjdYmceWIGIX42hrQSe+YXKBvG0mx36k5wCK0
 leU4s65gcgQIeWytVaOR5+QYUcgmqNrzSDZW+6C37uvYv76QJtIyN+TibMS2+Qw0G3jb
 5T5A==
X-Gm-Message-State: AOJu0YwM8sNvHDXlB4dq/oaXIXL05A1jXibsQdDteq2ZRFfqa1nBErbS
 in5JVsaRLFKji5ACDp4mIuF3eqSfGwng/NLwJ4ryBgx7N9kETpVgBCZooI736sX35mlKWrzU2Rr
 n5uFR
X-Gm-Gg: ASbGncucQKaqFnDlikL5Bkdc5mX+8MThekPEzxYqmuquLGsWx7KQn7ZgXrfj3mcyXr9
 CbHv+vSmiTvarMVKZWX3HsonsIMvahJ8vDdEblWYrIVgrWmL6GeZ38icdcLi0MlQRjeXbGF2Vuu
 Pzkm5ChKgu9Vr2FCTPeLMaGXzTKLlRiQUj1/s11Q8TfUjeXEzXprvnOdnF2J38Mu9lOLleJBvs7
 Zg/Qcq0wAC1F1KFcIOAku9BTyUTX4wy+oQEWPvv4aXw9jrUB0HnRtQNJ/KXsYMEwmDCBpDu1gwm
 3nGSU7Vc46QUUSH1NktChurH76RO9GndZRuAtVsuATlhQnrYcia5nuRFoH/DU2O51jhWsvgxwRz
 Mk2IZfGX0t2D9y17vJnzOwWUzZp+UvaKpXERTgFi4h4jnCD0I6nASumQzHdi+I6GJIsDBXEGFuq
 oj6vr43psHkQ==
X-Google-Smtp-Source: AGHT+IEv7lHGuZSFJNPJBX9kOEFCPKttj6tWESFef6SMt8oyPg5kS9q+NshfmBYb+4pK9tEZSr9+Og==
X-Received: by 2002:a05:622a:a06:b0:4b6:3aad:ea41 with SMTP id
 d75a77b69052e-4da4782d4eamr2834501cf.11.1758727664162; 
 Wed, 24 Sep 2025 08:27:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-84d7aa8fe10sm460350885a.22.2025.09.24.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 08:27:43 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:27:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Dimon" <dimon.zhao@nebula-matrix.com>
Cc: "dev" <dev@dpdk.org>, "Kyo Liu" <kyo.liu@nebula-matrix.com>, "Leon"
 <leon.yu@nebula-matrix.com>, "Sam" <sam.chen@nebula-matrix.com>
Subject: Re: =?UTF-8?B?5Zue5aSN77yaW1BBVENI?= v10 04/17] net/nbl: add
 Channel layer definitions and implementation
Message-ID: <20250924082740.42963a00@hermes.local>
In-Reply-To: <f8bb4de5-5a3f-4d5e-9acb-250e3039094e.dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250923035402.1759922-1-dimon.zhao@nebula-matrix.com>
 <20250923035402.1759922-5-dimon.zhao@nebula-matrix.com>
 <20250923112523.6579c851@hermes.local>
 <f8bb4de5-5a3f-4d5e-9acb-250e3039094e.dimon.zhao@nebula-matrix.com>
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

On Wed, 24 Sep 2025 17:40:00 +0800
"Dimon" <dimon.zhao@nebula-matrix.com> wrote:

> Hi Stephen,
> Thank you for your valuable feedback. I fully understand your concern abo=
ut pthread_cancel.
> However, due to our chip design constraints, during the remove process, a=
 few mailbox messages will still be sent after disabling mailbox interrupts.
> Since mailbox interrupts are already closed at this point, we cannot rely=
 on pipe reads to trigger mailbox ACK reception.
> Therefore, the acks of these mailbox messages have to be received using p=
olling. This is why we need the NBL_CHAN_INTERRUPT_READY flag.
> I've implemented an alternative, adding a state flag NBL_CHAN_TEARDOWN to=
 notify the polling task to exit.
> Here's the code modification.
> I've tested this on our hardware and it works fine.
> Do you think this modification is okay?
> static uint32_t nbl_chan_thread_polling_task(void *param)
> {
>  struct nbl_channel_mgt *chan_mgt =3D (struct nbl_channel_mgt *)param;
>  union nbl_chan_info *chan_info =3D NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
>  struct timespec time;
>  char unused[16];
>  ssize_t nr =3D 0;
>  time.tv_sec =3D 0;
>  time.tv_nsec =3D 100000;
>  while (true) {
>  if (rte_bitmap_get(chan_info->mailbox.state_bmp, NBL_CHAN_INTERRUPT_READ=
Y)) {
>  nr =3D read(chan_info->mailbox.fd[0], &unused, sizeof(unused));
>  if (nr < 0)
>  break;
> - }
> + } else if (rte_bitmap_get(chan_info->mailbox.state_bmp, NBL_CHAN_TEARDO=
WN)) {
> + break;
> + }
>  nbl_chan_clean_queue(chan_mgt);
>  nanosleep(&time, 0);
>  }
>  return 0;
> }
> static int nbl_chan_task_finish(void *priv)
> {
>  struct nbl_channel_mgt *chan_mgt =3D (struct nbl_channel_mgt *)priv;
>  union nbl_chan_info *chan_info =3D NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
> - pthread_cancel((pthread_t)chan_info->mailbox.tid.opaque_id);
> + /* set teardown state to cause mailbox thread to exit */
> + nbl_chan_set_queue_state(priv, NBL_CHAN_TEARDOWN, true);
>  close(chan_info->mailbox.fd[0]);
>  close(chan_info->mailbox.fd[1]);
>  chan_info->mailbox.fd[0] =3D -1;
>  chan_info->mailbox.fd[1] =3D -1;
>  rte_thread_join(chan_info->mailbox.tid, NULL);
>  return 0;
> }
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AStephen Hemminger <stephen@networkplu=
mber.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2025=E5=B9=B49=E6=9C=8824=E6=
=97=A5(=E5=91=A8=E4=B8=89) 02:25
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ADimon<dimon.zhao@nebula-matrix.com>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Adev<dev@dpdk.org>; Kyo Liu<kyo.liu@ne=
bula-matrix.com>; Leon<leon.yu@nebula-matrix.com>; Sam<sam.chen@nebula-matr=
ix.com>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH v10 04/17] net/nbl: add Ch=
annel layer definitions and implementation
> On Mon, 22 Sep 2025 20:53:49 -0700
> Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:
> > +
> > +static int nbl_chan_task_finish(void *priv)
> > +{
> > + struct nbl_channel_mgt *chan_mgt =3D (struct nbl_channel_mgt *)priv;
> > + union nbl_chan_info *chan_info =3D NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt=
);
> > +
> > + pthread_cancel((pthread_t)chan_info->mailbox.tid.opaque_id);
> > + close(chan_info->mailbox.fd[0]);
> > + close(chan_info->mailbox.fd[1]);
> > + chan_info->mailbox.fd[0] =3D -1;
> > + chan_info->mailbox.fd[1] =3D -1;
> > + rte_thread_join(chan_info->mailbox.tid, NULL);
> > + return 0;
> > +} =20
> Using pthread_cancel has a couple of problems: pthread_cancel uses a sign=
al and there is no safe equivalent on Windows
> A better alternative is to just close the pipe and then the read
> will safely exit the read(). Something like this:
> diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_h=
w/nbl_channel.c
> index a68060799c..c8572b3b4a 100644
> --- a/drivers/net/nbl/nbl_hw/nbl_channel.c
> +++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
> @@ -551,7 +551,7 @@ static int nbl_chan_task_finish(void *priv)
>  struct nbl_channel_mgt *chan_mgt =3D (struct nbl_channel_mgt *)priv;
>  union nbl_chan_info *chan_info =3D NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
> - pthread_cancel((pthread_t)chan_info->mailbox.tid.opaque_id);
> + /* closing pipe will cause mailbox thread to exit */
>  close(chan_info->mailbox.fd[0]);
>  close(chan_info->mailbox.fd[1]);
>  chan_info->mailbox.fd[0] =3D -1;
> Obviously, I don't have hardware so not tested.
> Yes, other drivers call pthread_cancel() and I am working on an RFC
> patch series to eliminate all those places.

Sure a bit or flag is a good alternate solution.
You do want to still close the pipe in the main thread
to cause the read() to get unblocked.
