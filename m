Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F960606A325
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=ihL2MHhe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B063640151;
	Thu, 19 Nov 2026 19:33:54 +0100 (CET)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by mails.dpdk.org (Postfix) with ESMTPS id C1D5B400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 19:33:53 +0100 (CET)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-67c0bd676eeso104942d50.3
 for <dev@dpdk.org>; Thu, 19 Nov 2026 10:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795113232; cv=none;
 d=google.com; s=arc-20260327;
 b=ODeKlJ2/lQSJUp6/8hD16EGv3YQp82RPzhqBx2RdWYFlkVGmg4YbfJp6vqHgKuGhut
 2mDoncxc3ogcSECcaxYnY/COrmhR1vB3jie3aGl+UV1TQ0MalaHL5ZPR3f8hYfz7XwTz
 yztqQmN+jtdWlkq0PDUOOmHMwQBAuiHIkZMijQKrkoLBQK/vGlK0ts34bqcA1/av2JqJ
 iLemEM+ZNYuXFwy11MnGvaO7paEd+sq6++6spEllSYcDl9rdBkZaem+5qUqz1o5Wmzed
 t9kHLMksCrFiMNOu3YU9WTEUFbHP79gcw5G4Ro0LaU5GRCkb1riswp+7fB3zxsZB/0JB
 dPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ohywXxoEqn912rQtyMVVCujOuApzO/xmbWJmhojok8w=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=BHlRmzF7pZCOuMSFlSceLA8ilthwqEe4TjQTLDRjeeeMkncXYWUhw7y0nCpktIuIum
 yagYesHQsRLgArAK7FP9Ty0jbUvabZ9uxCJas/0FmTReHl1A+80gIH8JYQoA60/ffTVr
 EjsVYwTOxWQnZG35R81m6OiKAY9Yu+2vS81m7UhSdr1jR7Xyab3KLURIi3aKOeEak8ss
 lQG4B9VFKb+rc4GrkP0KYZIeBi89KhNBzDrdg4RTvvm9JkKM4ZJbbwewGS5xxMS9ivYw
 YxDZFzwlGv4w6BU+kL/F2QXt4aiCSjM/3OydduUD/x22ixiYjnftnaHGBmNsUl42nQsm
 xolA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1795113232; x=1795718032; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ohywXxoEqn912rQtyMVVCujOuApzO/xmbWJmhojok8w=;
 b=ihL2MHhe+dLVTXlWLnn15nRiTwkSoXBXaetOts5dEXkpLHgf6XKfIogpQeNodGxLqP
 fRKr9uMK4xH2XnXK7owUyQXnutC/Y0ltUfHBEAJLobJLMxB7Z73BUJK/uAJ/ygyMjHZk
 SmHJs3FfySFzlNeFIwMB+Cogy9B5BlHS2vjio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113232; x=1795718032;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ohywXxoEqn912rQtyMVVCujOuApzO/xmbWJmhojok8w=;
 b=wR6Wv0Z3UOu/WPVhsxr3xWbYM7i+xLwmGtIr8KqkiVzZ6fTls02RHSB9i7h3W3G0wF
 jQc8jDu2FbBCNxHK8YKbIhf/tosHuRLP+B1gyuT3vK0c9SG6+n+z+XI3bHVSWHtudCBy
 CLvV/EcZy1sfEj7awmwt5pZVUYyC7HHxdcM7CqmmAz0VW2b0VACxsDoB6cc5kVI3Jxq+
 t/24Oe1eIm19f8Nom+4nBXqXa0Qg2h+xffLYJGd72Li6N+nCsmQz13XQ5k+qRukxP2Sq
 3qHaFoMwZ3EC6yeTEtl26Rxv4XD7Ir9Ki+5UOaHTsnoAc9LSYnIFlnEsJ3b9eYSZsHoz
 Vwtg==
X-Gm-Message-State: APuU4Z9B7pY5TVriVWT8PeFy6copYM9Qsdq6GdV+rLCR90lgJFmyk6wt
 xxCCFZGeiPaKvqrZsviZSBv2L3DzOSAIeBMisnaJcTtTu2mRWmI1AuiQTPwWSS5GvaM0hG8eCZs
 lIa3lxR0GJRuiT3wWwbfMOvuYpqG3iUx3kxujrAI3JunvlykuSxKG7oQciw==
X-Gm-Gg: AZFdTZef+A0NdQyau8gdEgEjL/g8vNJeOatWsSPuAqH9lj7fke1LDCKAek2gx4Yoggw
 Pl8fcy6eEICwlgMFkHNKyWmC5jwM3dfyhdV5TE6V4oD0zj3U68PkFlxyM+PiNVgBd/DLkcVi7QD
 qhhRdHAifrkBhJDEYhvgu49LndZLF5FM1R1gQVCrnsxHAAhLOw1m4/It8IgaIlL9Q5GmZ082/M1
 c6uSeqTtjuf3VQHRWfn4Xj12Qh8seQUHid6+VL7D+uuBV/uHkzGY8IyrP9aibFQ+HykyWoHy8Ic
 03OyEvntLiqUX6u7luejJe9rynCUnPnaQ1kVK/n2IUK71B+uYW9GQGznzvWl6V/GLGcneeSQyUX
 aeVcDuiY180cuxcRIWUejWLLYMJej8sgge9LS5L+GRaObXgu+WGZvpMvK7smAEW8gRaI/F1Lr++
 BE0lHaqYW0blRAxkPf
X-Received: by 2002:a05:690e:488f:20b0:67b:9a55:3382 with SMTP id
 956f58d0204a3-67df44234cdmr105478d50.56.1795113232362; Thu, 19 Nov 2026
 10:33:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 19 Nov 2026 13:33:14 -0500
X-Gm-Features: AclHuK8cWlJLiW4E4IvLT5ECmaUVjCqkQFkfhsivYm38i4_h54JXKHWWbSGSPXY
Message-ID: <CAJA6v3w9PcVMZf7Y9+pguhnLvnD3bzYY0HimKq0Aat7F2f=5tQ@mail.gmail.com>
Subject: November 19th, 2026 DTS Working Group Meeting Notes
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008c03a20660a55ebc"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000008c03a20660a55ebc
Content-Type: text/plain; charset="UTF-8"

Attendees
################################################
Dillon Ladd, UNH-IOL
Jake Bishop UNH-IOL
Andrew Bailey, UNH-IOL
Luca Vizzarro

General Discussions
==============================================
None

Patch Discussions
==============================================
Andrew put together a list of patches ranked by priority for review:

## High priority
* Pvp multi paths vhost/virtio performance test suites:
https://patchwork.dpdk.org/project/dpdk/list/?series=40035
Luca to look at and hopefully merge this today.
## Medium priority
* dts: add PVVP case to virtio suite:
https://patchwork.dpdk.org/project/dpdk/list/?series=38927
Likely not going to make it into 26.11
* dts: refactor flow suite with generator pattern:
https://patchwork.dpdk.org/project/dpdk/list/?series=38926
May make it into 26.11
* dts: update verbose output regex for VXLAN packets
https://patchwork.dpdk.org/project/dpdk/list/?series=38925
May make it into 26.11
* Eventdev perf testsuite and API
https://patchwork.dpdk.org/project/dpdk/list/?series=39943
Likely not going to make it into 26.11

Luca noted that for the AI code review, if there is a warning, contributors
should respond to the patch either with a fix or explaining why the AI is
wrong.

26.11 DTS Roadmap
==============================================
*roadmap for 26.11:
https://mails.dpdk.org/archives/dev/2026-September/345096.html
*Introduced Jake who is going to start contributing to DTS with the UNH-IOL
in the coming months.

Any other business
==============================================
Next Meeting: December 3rd, 2026

-- 
Dillon Ladd
Technical Manager, Open Source
UNH Interoperability Lab
21 Madbury Rd., Ste. 100, Durham, NH 03824
dladd@iol.unh.edu
https://www.iol.unh.edu

--0000000000008c03a20660a55ebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"background-color:transparent">Attendee=
s</span></div><div><span style=3D"background-color:transparent">###########=
###################</span><span style=3D"background-color:transparent">####=
##############</span></div><div><div class=3D"gmail-" style=3D"font-family:=
&quot;Google Sans&quot;,Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-=
size:medium"><div class=3D"gmail-ii gmail-gt" id=3D"gmail-:3hz" style=3D"di=
rection:ltr;margin:8px 0px 0px;padding:0px;font-size:0.875rem;overflow-x:hi=
dden"><div class=3D"gmail-a3s gmail-aiL" id=3D"gmail-:3hy" style=3D"directi=
on:ltr;font-style:normal;font-variant:normal;font-size-adjust:none;font-ker=
ning:auto;font-feature-settings:normal;font-stretch:normal;font-size:small;=
line-height:1.5;font-family:Arial,Helvetica,sans-serif;overflow:auto hidden=
"><div id=3D"gmail-avWBGd-138"><div dir=3D"ltr"><div>Dillon Ladd, UNH-IOL<b=
r>Jake Bishop UNH-IOL=C2=A0<br>Andrew Bailey, UNH-IOL<br>Luca Vizzarro</div=
><div><br>General Discussions<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>None<br><br>Patch Discussions<br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>Andrew put toget=
her a list of patches ranked by priority for review:</div><div>=C2=A0 <br>#=
# High priority<br>* Pvp multi paths vhost/virtio performance test suites: =
<a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D40035">ht=
tps://patchwork.dpdk.org/project/dpdk/list/?series=3D40035</a><br>Luca to l=
ook at and hopefully merge this today. <br>## Medium priority<br>* dts: add=
 PVVP case to virtio suite: <a href=3D"https://patchwork.dpdk.org/project/d=
pdk/list/?series=3D38927">https://patchwork.dpdk.org/project/dpdk/list/?ser=
ies=3D38927</a><br>Likely not going to make it into 26.11 <br>* dts: refact=
or flow suite with generator pattern: <a href=3D"https://patchwork.dpdk.org=
/project/dpdk/list/?series=3D38926">https://patchwork.dpdk.org/project/dpdk=
/list/?series=3D38926</a><br>May make it into 26.11<br>* dts: update verbos=
e output regex for VXLAN packets <a href=3D"https://patchwork.dpdk.org/proj=
ect/dpdk/list/?series=3D38925">https://patchwork.dpdk.org/project/dpdk/list=
/?series=3D38925</a> <br>May make it into 26.11<br>* Eventdev perf testsuit=
e and API <br>	<a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?ser=
ies=3D39943">https://patchwork.dpdk.org/project/dpdk/list/?series=3D39943</=
a><br>Likely not going to make it into 26.11 <br><br>Luca noted that for th=
e AI code review, if there is a warning, contributors should respond to the=
 patch either with a fix or explaining why the AI is wrong.=C2=A0<br></div>=
<div><br></div><div>26.11 <span class=3D"gmail-il">DTS</span> Roadmap<br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>*=
roadmap for 26.11: <a href=3D"https://mails.dpdk.org/archives/dev/2026-Sept=
ember/345096.html" target=3D"_blank">https://mails.dpdk.org/archives/dev/20=
26-September/345096.html</a></div><div>*Introduced Jake who is going to sta=
rt contributing to DTS with the UNH-IOL in the coming months.=C2=A0</div><d=
iv><br></div><div>Any other business<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><font color=3D"#888888"></font><div>Nex=
t Meeting: December 3rd, 2026<font color=3D"#888888"><font color=3D"#888888=
"><br></font></font></div><div><br></div></div></div></div></div></div></di=
v><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=
Dillon Ladd<div>Technical Manager, Open Source<br><font color=3D"#000000">U=
NH Interoperability Lab</font></div>21 Madbury Rd., Ste. 100, Durham, NH 03=
824<div><a href=3D"mailto:dladd@iol.unh.edu" target=3D"_blank">dladd@iol.un=
h.edu</a></div><div><a href=3D"https://www.iol.unh.edu/" style=3D"color:rgb=
(17,85,204)" target=3D"_blank">https://www.iol.unh.edu</a></div><div><img s=
rc=3D"https://www.iol.unh.edu/sites/all/themes/custom/iol2013/img/logo.png"=
 width=3D"200" height=3D"52"><br></div></div></div></div>

--0000000000008c03a20660a55ebc--
