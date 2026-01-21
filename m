Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC1DC44502
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 10:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AE1E427B8;
	Wed, 21 Jan 2026 11:16:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E947A400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 11:16:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768990603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oOcQR0Db8zM2lL+Op0Xe9auSFt1gwF8dnTBQcS2Qbv4=;
 b=PTrBCr1EUxotqfkwG3db/bfc85eTd4BdIEv3FE13j29uITYstOxMmrTJCNPGxtOUM7FY4Y
 o2Xh5SzAfauqrWfBfPjw1/iwcZxJA1RLoE0Gbj7NEeCa2K/BxMq8fHMyvdn2KTF/HyYWoo
 HCacOrC4eZcdyXpY7/25YYU7mZh+0m4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-AOb58o8SMPCHgAAE-HD_7g-1; Wed, 21 Jan 2026 05:16:40 -0500
X-MC-Unique: AOb58o8SMPCHgAAE-HD_7g-1
X-Mimecast-MFC-AGG-ID: AOb58o8SMPCHgAAE-HD_7g_1768990599
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-383558ea1b7so33335941fa.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 02:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768990598; x=1769595398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOcQR0Db8zM2lL+Op0Xe9auSFt1gwF8dnTBQcS2Qbv4=;
 b=V8RSCqEBIGzwJxa4WdegeYbrLkoYm62FHjtLwC1olQWhgMNv3acwFd8t1Z7ggS15k9
 NDkX71HR+oyEf9mzMlgukUbwCCxkiTTY63V6BsB2/aP2CYwVwR82NeXZD3OrgOFRiMLN
 VzoC6B+BZZnZt74erJ5JIGwgJQ8s6YXf3fXh+lR2fnxTH4SNNljnRKoEh2tCnhKaPfGL
 XSgF/wYlwftxYnfJ8rwM7V5g9Q1aSn449Pu+H54QUB+/esBSXAn8yHyMKk4jaVSQD9U1
 cUvn0wrnRiR8xtOLOO5Su+A4yJrpuVzaSK7pgdr/Fecj8a1F4jh/DTwi++YOgAjUT9zt
 4QNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH0k4Q1BwQ+baS17NEEpmEWZH/A6aBrJW1fsaZyvAGoGU/F+1LIyWd8vZbyt6D/7rcw+c=@dpdk.org
X-Gm-Message-State: AOJu0YzSRNR4rZ6aWHIxNXyx9nii9K+C2z5a6iuxrbpZs19AWIOjOGru
 Hp4mFsjQV8Ia3izjwbuP9//0KHKY2KCkwQebmmK0UKLmOOmOLVZnBvdJxj1WrkFIgrgtLB1kKAP
 JOR6iZlNLGwWRRX1Ng/OV6hCi9yvkD+XDdSnV2nrTxm7aNiKFTPKmKVQAebrxE4PrEyVOfdKH6H
 dbpW7aw3jIySyuK5zjPs0=
X-Gm-Gg: AZuq6aLn/FYMrZOXSLF1wnEBVZ7nn/9zMnkQGRUxdVKDJgLeUbRcWOnxNjgyQ5rTG7D
 cF84q0m2lwSzTNF2YjMIvhZBd4InsIVYfPQt5BESLG+Imq03XxpJeBFnm/fGgerC/ZNlYem/LXO
 ZjHsd4HTzelCdLnNQ9lU7yPnvGth9raCLYJbIEgSm8cPxDg/vRZWgHoG0I78yVdfowPxmZ
X-Received: by 2002:a2e:bc1c:0:b0:383:26ac:4fca with SMTP id
 38308e7fff4ca-38384147807mr63274161fa.4.1768990598485; 
 Wed, 21 Jan 2026 02:16:38 -0800 (PST)
X-Received: by 2002:a2e:bc1c:0:b0:383:26ac:4fca with SMTP id
 38308e7fff4ca-38384147807mr63274141fa.4.1768990598005; Wed, 21 Jan 2026
 02:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20260120230806.192421-1-sismis@dyna-nic.com>
 <20260120230806.192421-2-sismis@dyna-nic.com>
 <edeabad0cfe7460d82be2d9673b7ad9b@huawei.com>
In-Reply-To: <edeabad0cfe7460d82be2d9673b7ad9b@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 11:16:26 +0100
X-Gm-Features: AZwV_QijSriuyqswgkczQ6JJohGB-3hSfK8OJVKYEzMo80UhiXwDcqGoq2Gypso
Message-ID: <CAJFAV8w7o_GB=e8401Ot6An6bwdT+ihLPZ7nfRieTGP+VDZuyQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dts: fix invalid f-string syntax in testpmd API
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Lukas Sismis <sismis@dyna-nic.com>, "dts@dpdk.org" <dts@dpdk.org>,
 "dev@dpdk.org" <dev@dpdk.org>, "dmarx@iol.unh.edu" <dmarx@iol.unh.edu>,
 "abailey@iol.unh.edu" <abailey@iol.unh.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UI4n4tlGe6CJKo6rpdZr-gXT9a6m1byRhaYh73lAuSk_1768990599
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

Hello,

On Wed, 21 Jan 2026 at 10:46, Marat Khalili <marat.khalili@huawei.com> wrote:
> >
> > Fix f-string syntax errors where double quotes were nested inside
> > f-strings that also use double quotes as delimiters.
> > ---
> >  dts/api/testpmd/__init__.py | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> > index a20dedc25a..703cae487e 100644
> > --- a/dts/api/testpmd/__init__.py
> > +++ b/dts/api/testpmd/__init__.py
> > @@ -227,7 +227,7 @@ def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
> >              InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
> >                  start or ports fail to come up.
> >          """
> > -        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
> > +        self.send_command(f"start tx_first {burst_num if burst_num is not None else ''}")
> >          if verify:
> >              # If forwarding was already started, sending "start" again should tell us
> >              start_cmd_output = self.send_command("start")
> > @@ -898,11 +898,11 @@ def set_qinq_strip(self, port: int, enable: bool, verify: bool = True) -> None:
> >              vlan_settings = self.show_port_info(port_id=port).vlan_offload
> >              if enable ^ (vlan_settings is not None and VLANOffloadFlag.QINQ_STRIP in vlan_settings):
> >                  self._logger.debug(
> > -                    f"Failed to {"enable" if enable else "disable"}"
> > +                    f"Failed to {'enable' if enable else 'disable'}"
> >                      f"QinQ strip on port {port}: \n{qinq_cmd_output}"
> >                  )
> >                  raise InteractiveCommandExecutionError(
> > -                    f"Failed to {"enable" if enable else "disable"} QinQ strip on port {port}"
> > +                    f"Failed to {'enable' if enable else 'disable'} QinQ strip on port {port}"
> >                  )
> >
> >      def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
> > @@ -1535,7 +1535,7 @@ def set_port_mbuf_fast_free(
> >              InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully.
> >          """
> >          mbuf_output = self.send_command(
> > -            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
> > +            f"port config {port_id} tx_offload mbuf_fast_free {'on' if on else 'off'}"
> >          )
> >
> >          if verify and "Error" in mbuf_output:
> > --
> > 2.43.7
>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
>
> Thank you, this noise in the compile logs was a bit annoying. I have to ask
> however, how did it pass? Are we ignoring some errors?

Yes, I ended with the same conclusion and sent a fix earlier.
https://patchwork.dpdk.org/project/dpdk/patch/20260121100127.1701459-1-david.marchand@redhat.com/


-- 
David Marchand

