Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7165C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 22:01:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A467940395;
	Tue,  4 Mar 2025 23:01:05 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 18DA5402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 23:01:04 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso5350082a91.3
 for <dev@dpdk.org>; Tue, 04 Mar 2025 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741125663; x=1741730463; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6lWDEhuJpynFax73IZ5U6qlO1PAgK0n1pAOJpkd3OVg=;
 b=MppGUg9HuvHOiUg21i8KtYPgLXOmr30iGpDGsGvKlveM/nFc5xBnhkQkrprbhKPIOL
 AthOgomgwJFysy+maFrvuNfMBbKOwIR5YjBcvjE6uCa6oZWdu56y/9qr5Mst8rdydA53
 o0/jRf+csZhLief0nTMIvJF1mJKxod8sv7UUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741125663; x=1741730463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lWDEhuJpynFax73IZ5U6qlO1PAgK0n1pAOJpkd3OVg=;
 b=kYkTRZJm64vMdT9e0bwuYOJqfQQhVbONFFynt8DYyJLmaW1iCMFYJo3O26BS16V5Se
 wygkSwWWKEQC5EpEkP/GU5KVFyFH5n96FmYulrnBaNJxJBQDoMfVOlpj5yu8OrpolwFD
 R2MYIBDDuQ+i7dGJGj7sGdDFtB3H0qsmiFZaRr3EqZUMzDty/Q7QOkisSBwBS3taWdgI
 dtP/I4/wTtr9zgmrPSmck4+LM+mmIRKS35gb/u5A2XD68xXbDwTFYrklOH673kSNifa0
 ihGDwZZfWSwCCcSOu8svHN7NSvQTVvTGXu09WorFZ9lQ/54x6WD3eutdEE5JW969atSX
 8PuQ==
X-Gm-Message-State: AOJu0YzVObWGMhOLXxXU5mrZC/pKiQcUYd6B70Q+vYV2HzDSteU2Jhwb
 /1BcPC0xPxTUXxcafpXEIrVhtzrrRcHJ4AN2HvvI4kgjJFdR7NxUkwTLle+PlS9vjp4lkT1EarV
 rw7AKmc2lwEqPiAhz4s1Uy0FUUfpQwB+H3Lk12w==
X-Gm-Gg: ASbGncuGf0wZHyvcInpqp2TsW4DmeSx67NVA22CAiqG9YSPo+Wv12vUkPsJpXonuA++
 qzX1+I7lZfgEZ0qarnCGoKzSwbR7KLfUnWEPbUJhzpkjE2umzxDql4MHkiwQPrh9z0cDWwJCKkI
 QAfy0vhh4FX1feBjhU+H4s6BpB8b2jOeUGpXKhIiC6NkR+nxnRuR0VgOfzALI=
X-Google-Smtp-Source: AGHT+IFqXeSg4sMDwlOJ8C1jlm9rVwRGUrAvn9WKGxjCYbaKykT25j2qfKg6CQxJLwsx5GwGxULSFhwkWsJINjXnAlM=
X-Received: by 2002:a17:90b:514c:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-2ff4975359dmr1388317a91.19.1741125663141; Tue, 04 Mar 2025
 14:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20250304155036.383468-1-david.marchand@redhat.com>
In-Reply-To: <20250304155036.383468-1-david.marchand@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Mar 2025 16:57:29 -0500
X-Gm-Features: AQ5f1JoSwYBKTTHkBc1jf4V4GVLji1CRIBn1Va3Wrd8BYMgSMbqmzhdxbPwTbl0
Message-ID: <CAJvnSUDqz5pTH9sWkxK1rqWA2MLnLop4jefWbZ3UQ_LUxDVTWw@mail.gmail.com>
Subject: Re: [PATCH] ci: point at GitHub mirror.
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>
Content-Type: multipart/alternative; boundary="000000000000a95362062f8b68d5"
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

--000000000000a95362062f8b68d5
Content-Type: text/plain; charset="UTF-8"

I see a spurious dpdk-test fail for this, on per_lcore_autotest, it
remotely launches an lcore which is running though it should not be able
to. I threw the relevant blurbs below - I will bring this to Bugzilla since
obviously your patch is unrelated.

We can do a retest if you want - otherwise I think you are safe to ignore
this fail.

 78/119 DPDK:fast-tests / per_lcore_autotest             FAIL
1.14s   (exit status 255 or signal 127 SIGinvalid)
16:49:56 DPDK_TEST=per_lcore_autotest MALLOC_PERTURB_=178
/root/workspace/Generic-Unit-Test-DPDK/dpdk/build/app/dpdk-test --no-huge
-m 2048
----------------------------------- output
-----------------------------------
stdout:
RTE>>per_lcore_autotest
on socket 0, on core 1, variable is 1
wait 100ms on lcore 1
It does remote launch successfully but it should not at this time
Test Failed
RTE>>wait 100ms on lcore 1
stderr:
EAL: Detected CPU lcores: 16
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
APP: HPET is not enabled, using TSC as default timer
------------------------------------------------------------------------------

The test:

```
test_per_lcore(void)
{
unsigned lcore_id;
int ret;

rte_eal_mp_remote_launch(assign_vars, NULL, SKIP_MAIN);
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) < 0)
return -1;
}

rte_eal_mp_remote_launch(display_vars, NULL, SKIP_MAIN);
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) < 0)
return -1;
}

/* test if it could do remote launch twice at the same time or not */
ret = rte_eal_mp_remote_launch(test_per_lcore_delay, NULL, SKIP_MAIN);
if (ret < 0) {
printf("It fails to do remote launch but it should able to do\n");
return -1;
}
/* it should not be able to launch a lcore which is running */
ret = rte_eal_mp_remote_launch(test_per_lcore_delay, NULL, SKIP_MAIN);
if (ret == 0) {
printf("It does remote launch successfully but it should not at this
time\n");
return -1;
}
RTE_LCORE_FOREACH_WORKER(lcore_id) {
if (rte_eal_wait_lcore(lcore_id) < 0)
return -1;
}

return 0;
}
```

--000000000000a95362062f8b68d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I see a spurious dpdk-test fail for this, on per_lcor=
e_autotest, it remotely launches an lcore which is running though it should=
 not be able to. I threw the relevant blurbs below - I will bring this to B=
ugzilla since obviously your patch is unrelated.</div><div><br></div><div>W=
e can do a retest if you want - otherwise I think you are safe to ignore th=
is fail.</div><div><br>=C2=A078/119 DPDK:fast-tests / per_lcore_autotest =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.14s =C2=A0 (exit status 255 or signal 127 SIGinvalid)<br>16=
:49:56 DPDK_TEST=3Dper_lcore_autotest MALLOC_PERTURB_=3D178 /root/workspace=
/Generic-Unit-Test-DPDK/dpdk/build/app/dpdk-test --no-huge -m 2048<br>-----=
------------------------------ output -----------------------------------<b=
r>stdout:<br>RTE&gt;&gt;per_lcore_autotest<br>on socket 0, on core 1, varia=
ble is 1<br>wait 100ms on lcore 1<br>It does remote launch successfully but=
 it should not at this time<br>Test Failed<br>RTE&gt;&gt;wait 100ms on lcor=
e 1<br>stderr:<br>EAL: Detected CPU lcores: 16<br>EAL: Detected NUMA nodes:=
 2<br>EAL: Detected static linkage of DPDK<br>EAL: Multi-process socket /va=
r/run/dpdk/rte/mp_socket<br>EAL: Selected IOVA mode &#39;VA&#39;<br>EAL: VF=
IO support initialized<br>APP: HPET is not enabled, using TSC as default ti=
mer<br>--------------------------------------------------------------------=
----------<br><br></div><div>The test:</div><div><br></div><div>```</div><d=
iv>test_per_lcore(void)<br>{<br>	unsigned lcore_id;<br>	int ret;<br><br>	rt=
e_eal_mp_remote_launch(assign_vars, NULL, SKIP_MAIN);<br>	RTE_LCORE_FOREACH=
_WORKER(lcore_id) {<br>		if (rte_eal_wait_lcore(lcore_id) &lt; 0)<br>			ret=
urn -1;<br>	}<br><br>	rte_eal_mp_remote_launch(display_vars, NULL, SKIP_MAI=
N);<br>	RTE_LCORE_FOREACH_WORKER(lcore_id) {<br>		if (rte_eal_wait_lcore(lc=
ore_id) &lt; 0)<br>			return -1;<br>	}<br><br>	/* test if it could do remot=
e launch twice at the same time or not */<br>	ret =3D rte_eal_mp_remote_lau=
nch(test_per_lcore_delay, NULL, SKIP_MAIN);<br>	if (ret &lt; 0) {<br>		prin=
tf(&quot;It fails to do remote launch but it should able to do\n&quot;);<br=
>		return -1;<br>	}<br>	/* it should not be able to launch a lcore which is=
 running */<br>	ret =3D rte_eal_mp_remote_launch(test_per_lcore_delay, NULL=
, SKIP_MAIN);<br>	if (ret =3D=3D 0) {<br>		printf(&quot;It does remote laun=
ch successfully but it should not at this time\n&quot;);<br>		return -1;<br=
>	}<br>	RTE_LCORE_FOREACH_WORKER(lcore_id) {<br>		if (rte_eal_wait_lcore(lc=
ore_id) &lt; 0)<br>			return -1;<br>	}<br><br>	return 0;<br>}</div><div>```=
</div><div><br><br></div></div>

--000000000000a95362062f8b68d5--
