Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E18CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 03:04:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2A52402E5;
	Fri,  7 Nov 2025 04:04:12 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1B7E74013F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 04:04:11 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b6cf07258e3so161622a12.0
 for <dev@dpdk.org>; Thu, 06 Nov 2025 19:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762484650; x=1763089450; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z28DXo/EakcrAdCUod3PgrBzjsaNRwlTY3eyJQhtrqM=;
 b=Rkcx8RNbEz6PoNte7qxTE13AfEQQxoGotgdwBkYjDqad7i/RVcSoI7SoP9Qk5ShtpN
 +2aFSQza+v54qplnAAMXO/bmeLMFavNRalQFrvy5b0+oXXQRr3fQJCsMejicJk+E2FRV
 4fsG2I9vdbo+Tzj0aidQ1QESWAHGtW9ANa4SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762484650; x=1763089450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z28DXo/EakcrAdCUod3PgrBzjsaNRwlTY3eyJQhtrqM=;
 b=CSRA7b0Mc0QZs9OxbeqlQ9V9tp9UT13koQ+0nwUdemyY3plvKD9o75F+L950NoZeVJ
 Qj7K6yo/qczMLLrk32Ha3UCanckvfDaLMm6puzI0zE5O5G13jOcD9nHw198nAQPoks9l
 1VshDaT/nBCcCH8ssrvT8YGKuBSDXwwCOVDfDOIBqAQjbVQWVGSziAVSTdOJEkdVcSee
 1r6tovbZql9srsgwWgfJ9mUHpfZHjljVYLOQMOuynUAyEPuChg6UF1wYYjUc1fAz8XRT
 LshBfwHkqE7g8bg5FJU/Co5B5MQVLGef0RmDmy5zkLm22Ta6Y1H/QVwTbgzvzURWYoe/
 xEzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVP5c+JJOgcvwQOOBfZDhCXMYnmMPASWgRhREAGDTj3TyshLPEnP6saDRWWm7l2ZbSYPY=@dpdk.org
X-Gm-Message-State: AOJu0YzDj5xxj+jAT4fejsRC6eRS5SxHgTI/NIjx2VodESiO0JubYH2i
 RgfU4H14hSGcCDT68Xn9JETS6Z17TCEwBvc901b5dvD8BXcCeoPxc9rLQNUXuHRCgK3LWbGXB3e
 9CSR4Xs8CQgXdO+WsHx0QZoshLD0wRkFKZg2csLLqTg==
X-Gm-Gg: ASbGncspQsGw5ETA5/jX19QVXoDGbo5w5uAj6UwKSaEBKwBmLmf56ZlL1UPcKmfuQ5s
 4VtogpRN0XXNkIDoT3f9UEVn28iA3ghmWy13s87oofyK3kBDIsZBRAeoOBrqhzPf4m3sN6gbOsW
 5llcf6BV+6l2pOtPIwJNdrmKY8BArLcVzm3JaHNN48d43mcyxhavfOV2kigniNLFIvrVN3Hin27
 b2vUW5BVgVK/sCVRvqciNy2Oy/MNGZUz2L7HXZaIMF9seFsh/C/BMlQl4VC7s8rMNeD9PlyBBR5
 gEk+iee7cTXJH7+yHePuZZstCW8=
X-Google-Smtp-Source: AGHT+IFzbQWFV7ozoKWE0y1pG6Xz3qQYq449OUpqsNf93dqq4/KBjQOLi0/hWp6tN+fN2BDWOb5goJSuArEgh3gEJQM=
X-Received: by 2002:a17:902:ecca:b0:295:a1a5:baee with SMTP id
 d9443c01a7336-297c03d28dfmr20877035ad.4.1762484650093; Thu, 06 Nov 2025
 19:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20250908014154.82938-1-probb@iol.unh.edu>
 <20251105194925.1507334-1-probb@iol.unh.edu>
 <CABJ3N2XcnGVT2q-BAjutbUYgHjHJH8KTn9nWNXQsdRc82CadhA@mail.gmail.com>
In-Reply-To: <CABJ3N2XcnGVT2q-BAjutbUYgHjHJH8KTn9nWNXQsdRc82CadhA@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Nov 2025 22:03:00 -0500
X-Gm-Features: AWmQ_bmzBFlte9ivGpsoOmcNNHv8ky3SNh8BqZVdrPGmVd-Kgyy7dlBhKA62byw
Message-ID: <CAJvnSUCkScKeTEoFscfUW+9192iaLpD9kK6YKC=5MOMgo_LV2g@mail.gmail.com>
Subject: Re: [PATCH v2] dts: testpmd link check on port start
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000007dcc680642f86fa1"
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

--0000000000007dcc680642f86fa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, yep not sure how I missed running dts-check-format!

Applied to next-dts with the dts-check-format fix squashed.

On Thu, Nov 6, 2025 at 10:05=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

>  Raises:
> +        InteractiveCommandExecutionError: If the ports has been started
> but a port link will not come up.
> nit: fails check-format because the line is too long.
>
> Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
>
> On Wed, Nov 5, 2025 at 2:50=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:
>
>> When running our existing DTS testsuites on a new
>> NIC we observed packets would not transmit from
>> the traffic generator to the system under test
>> even after DPDK testpmd and the NIC under test
>> had indicated readiness. After investigation, we
>> determined that the existing readiness check in DTS
>> for testpmd start (checking that port is started)
>> is insufficient, because on some systems the link
>> will remain down for some measurable time, creating
>> a race condition between the testpmd port's link
>> coming up and the DTS execution reaching the packet
>> transmission step. This change will ensure that
>> testpmd start will block until the port is reporting
>> that its link is up. In addition, the interval in
>> between checking the link state has been reduced in
>> order to speed up the execution.
>>
>> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
>> Tested-by: Patrick Robb <probb@iol.unh.edu>
>> ---
>>  dts/api/testpmd/__init__.py | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
>> index aadb7f4e70..49a847494a 100644
>> --- a/dts/api/testpmd/__init__.py
>> +++ b/dts/api/testpmd/__init__.py
>> @@ -93,6 +93,9 @@ def _requires_started_ports(func: TestPmdMethod) ->
>> TestPmdMethod:
>>
>>      Args:
>>          func: The :class:`TestPmd` method to decorate.
>> +
>> +    Raises:
>> +        InteractiveCommandExecutionError: If the ports has been started
>> but a port link will not come up.
>>      """
>>
>>      @functools.wraps(func)
>> @@ -100,6 +103,10 @@ def _wrapper(self: "TestPmd", *args: P.args,
>> **kwargs: P.kwargs) -> Any:
>>          if not self.ports_started:
>>              self._logger.debug("Ports need to be started to continue.")
>>              self.start_all_ports()
>> +        if get_ctx().topology.type is not LinkTopology.NO_LINK:
>> +            for port in self.ports:
>> +                if not self.wait_link_status_up(port.id):
>> +                    raise InteractiveCommandExecutionError(f"Port {
>> port.id} link failed to come up.")
>>
>>          return func(self, *args, **kwargs)
>>
>> @@ -265,7 +272,7 @@ def wait_link_status_up(self, port_id: int,
>> timeout=3DSETTINGS.timeout) -> bool:
>>              port_info =3D self.send_command(f"show port info {port_id}"=
)
>>              if "Link status: up" in port_info:
>>                  break
>> -            time.sleep(0.5)
>> +            time.sleep(0.25)
>>          else:
>>              self._logger.error(f"The link for port {port_id} did not
>> come up in the given timeout.")
>>          return "Link status: up" in port_info
>> --
>> 2.49.0
>>
>>

--0000000000007dcc680642f86fa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, yep not sure how I missed running dts-check-format=
!<div><br></div><div>Applied to next-dts with the dts-check-format fix squa=
shed.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 6, 2025 at 10:05=E2=80=AFAM An=
drew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr">=C2=A0Raises:<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCo=
mmandExecutionError: If the ports has been started but a port link will not=
 come up.<br>nit: fails check-format because the line is too long.<div><br>=
Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" targe=
t=3D"_blank">abailey@iol.unh.edu</a>&gt;</div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 5, 2025 at 2:50=
=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D=
"_blank">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">When running our existing DTS testsuites on a new=
<br>
NIC we observed packets would not transmit from<br>
the traffic generator to the system under test<br>
even after DPDK testpmd and the NIC under test<br>
had indicated readiness. After investigation, we<br>
determined that the existing readiness check in DTS<br>
for testpmd start (checking that port is started)<br>
is insufficient, because on some systems the link<br>
will remain down for some measurable time, creating<br>
a race condition between the testpmd port&#39;s link<br>
coming up and the DTS execution reaching the packet<br>
transmission step. This change will ensure that<br>
testpmd start will block until the port is reporting<br>
that its link is up. In addition, the interval in<br>
between checking the link state has been reduced in<br>
order to speed up the execution.<br>
<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"=
_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/testpmd/__init__.py | 9 ++++++++-<br>
=C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index aadb7f4e70..49a847494a 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -93,6 +93,9 @@ def _requires_started_ports(func: TestPmdMethod) -&gt; Te=
stPmdMethod:<br>
<br>
=C2=A0 =C2=A0 =C2=A0Args:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0func: The :class:`TestPmd` method to deco=
rate.<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError: If the ports=
 has been started but a port link will not come up.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
@@ -100,6 +103,10 @@ def _wrapper(self: &quot;TestPmd&quot;, *args: P.args,=
 **kwargs: P.kwargs) -&gt; Any:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.ports_started:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(&quot;Po=
rts need to be started to continue.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.start_all_ports()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if get_ctx().topology.type is not LinkTopology=
.NO_LINK:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.wait_l=
ink_status_up(<a href=3D"http://port.id" rel=3D"noreferrer" target=3D"_blan=
k">port.id</a>):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(f&quot;Port {<a href=3D"http://port.id" =
rel=3D"noreferrer" target=3D"_blank">port.id</a>} link failed to come up.&q=
uot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return func(self, *args, **kwargs)<br>
<br>
@@ -265,7 +272,7 @@ def wait_link_status_up(self, port_id: int, timeout=3DS=
ETTINGS.timeout) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_info =3D self.send_com=
mand(f&quot;show port info {port_id}&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;Link status: up&qu=
ot; in port_info:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.5)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.25)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.error(f&quot;T=
he link for port {port_id} did not come up in the given timeout.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;Link status: up&quot; in por=
t_info<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000007dcc680642f86fa1--
