Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D82CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 19:36:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C393402BB;
	Thu,  2 Oct 2025 21:36:58 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0B9A3402A6
 for <dev@dpdk.org>; Thu,  2 Oct 2025 21:36:56 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b5a631b9c82so926328a12.1
 for <dev@dpdk.org>; Thu, 02 Oct 2025 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759433815; x=1760038615; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aWK295z44VRe6EJkfHihF4a5RopwM5y3hz+C9SBF/ks=;
 b=IFlf4dpud343tBDuHkh1Kx4NYqbOclHNxwlBfek1PoK6tOp/4DhVPJQ/JZGNyUPtva
 y9mOzOv5jIXgLAGtR+JVFTglzFedXX9OD/IP1yqweYmWPiio0u6BznyaefiBYMIq5ssR
 PjOZMsqGR8DA1PKxOhDfafDbf1kEz9b4fGgfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759433815; x=1760038615;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWK295z44VRe6EJkfHihF4a5RopwM5y3hz+C9SBF/ks=;
 b=lnvDskHQao5GsAukFVHwUofUn1YFAVfbD5QCSUNhJz0t/Cpb8vYTjhze8oUdqCVKrD
 yrmCy6kQTEs9JogTDrsVxxus22xqYo1Vd1j2bwbBjFxTzTz4nxKNQ+S5epjC5qVYhLkF
 hVcVcZOjhPy42lR64XHVDDNmvDPSj3VnlyM/8QEpN7LthHX6ANScNbf+tioAqs+pdVnb
 Uw6iWGDpRpMekYyJqMtB1vt5tjEfn3qYf+VciLf/TeW6Q/Tk/MDzBrDKyBww7Lt0gV1N
 zPz7o2Dl6+AKGCFVlnhyXMBi6aP5lGfymOvcpQbJc0I5w5y4EkeuncfAP29BaXbpTU86
 QaVA==
X-Gm-Message-State: AOJu0YyDplTuMqMV/bGV7XX2zkGTBKT9UKgJQh6Agbw6kxTQU8aU/YII
 bBbvEdUz0FRwABsF2mBJFPzWwiK9xsSwiAaaz0Gj0SoV8xzlNJu4mRlixxTnvA5KXuF2vHxJ9jo
 NCca35CFtOvuCFt4/RZkly8bwzKIgeTjVSgYfBzYJTw==
X-Gm-Gg: ASbGncuZxpMjzc0AqAfpRNKbr6W44vK6tsiejdtYD+7P886KAkqS9DPa9XhkAUGQRja
 x+CVEJ9Y2eZDcPVYmtg0wJe/BitMKOyHNqa6+x4UYykewNKM2dRwJvlQkOTgxw5m9fYecJpnN/I
 V5PsKQDdQDnwBrPQMrEkTJW9b3izO8LuoCKQqwcPznVPOSwx0j3HyXcpUUldd0WLUHStjWpR/V+
 FOFIhq266ul5505HO0zjULzi/NEJZ4owObhvzT1brRS5ujxAhNIN+Z4bd5I+1BkbR1RKaiCvC8=
X-Google-Smtp-Source: AGHT+IFz1nXzIOwwbuD7o0V/wG1tdTEvFyw+BeGM09ofOQz+ujWDeEQdIcPivrWnhn9nW9tzol0Ut/rzeCGReoGnj7E=
X-Received: by 2002:a17:903:38d0:b0:262:d081:96c with SMTP id
 d9443c01a7336-28e9a546837mr5444795ad.17.1759433814891; Thu, 02 Oct 2025
 12:36:54 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Oct 2025 15:36:23 -0400
X-Gm-Features: AS18NWBI-kMFm6Jnzii1So_dC3PppqvP0XCTtVl0xGDN34r6_4IWaMgJ9Kaw-PM
Message-ID: <CAJvnSUCH62hqKkacrB5QG8uONS_XhKC2fnk68VTmKfCxfKDnhg@mail.gmail.com>
Subject: Community CI Meeting Minutes - September 18 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000008af0eb0640321ba2"
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

--0000000000008af0eb0640321ba2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
September 18, 2025
Attendees
   1. Patrick Robb
   2. Aaron Conole
   3. Luca Vizzarro
   4. Sadashiva Rao
   5. Paul Szczepanek
   6. Aaron Conole

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
   * UNH guys met with governing board about the DTS work this year and
priorities going forward in remaining 2025 time and in 2026 (pending next
contract).
   * We have published the new DTS instructional videos, showing how to
setup and run the framework, and how to write a testcase.
        * Should produce a part 2 video soon showing some of the minor
details like how to use the logger etc.
   * OvS conference: Call for papers now, ending Monday
CI Status

---------------------------------------------------------------------
AWS Lab
   * None

---------------------------------------------------------------------
UNH-IOL Community Lab
   * PW-CI: Working on standing up an instance of pw-ci, so we can start to
poll for some patches and better understand if this can be used in our lab
        * Adam made a graphic about how pw-ci works and sent it to Aaron to
see whether our understanding is correct
        * It could also be committed to the repo if that was considered a
value
   * DTS:
        * Mlx5_core: A patch has been merged which changes how the device
reports MTU, causing the MTU DTS testsuite to fail. Patrick needs to check
what the issue is and send the info to the submitter.
   * Sadashiva asked what platforms/tests are being run at the community
lab:
        * Intel i40e and ice testing:
        * Performance:
            * Single core forwarding test
        * Functional testing:
            * Various ethdev tests found in
https://git.dpdk.org/tools/dts/tree/tests
        * Cryptodev testing:
            * Still using legacy DTS for this
        * Patrick to send a summary to Satashiva for Intel based testing at
the Community Lab

---------------------------------------------------------------------
Intel Lab
   * None

---------------------------------------------------------------------
Github Actions Robot
   * Aaron has sent out to a few CI people an initial patch porting pw-ci
over to Python.
        * Adam and Patrick from UNH will do a review
        * Coderabbit and sourcery.ai:
            * Reporting into DPDK patchwork
        * Consensus from tech board is that it is sometimes catching
issues, but also making a lot of =E2=80=9Cnoise.=E2=80=9D Unclear whether i=
t is a positive
or negative value.
            * Possibly going to disable coderabbit for now and enable a
competing system.

---------------------------------------------------------------------
Loongson Lab
   * None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
   * Aaron=E2=80=99s AI CI systems are sending some reviews for DTS patches=
:
        * https://github.com/ovsrobot/dpdk/pull/49
   * DTS API Series:
        * Looks good. Patrick to merge.
        * Want to ensure that there are no bugs introduced to testsuites
through this patch. UNH guys to run testing on our hardware.
   * Testsuite docs:
https://patchwork.dpdk.org/project/dpdk/patch/20250910194259.1027220-2-paul=
.szczepanek@arm.com/
        * Depends on the API update series, which is being merged today.
   * Virtio testing: Dean is working on a virtio forwarding testsuite to
start
        * Contains virtio testing testcases both with the backend vhost in
=E2=80=93no-pci mode and also others that have the backend vhost forward pa=
ckets
from physical NICs
        * V1 Submitted.
   * Single_core_forwarding
        * Different drivers require different testpmd flags to optimize
performance. So, reading SUT node config from get_ctx() and switching
testpmd args based on this.
            * Without this change, some NICs will perform below their
forwarding baseline
        * Build args for Intel:
            * Intel uses a special flag for the rx descriptor byte size,
which would need to be included in the user=E2=80=99s test_run.yaml for the=
 SUT to
build =E2=80=9Ccorrectly.=E2=80=9D
   *
https://patchwork.dpdk.org/project/dpdk/patch/20250910122749.8277-1-abailey=
@iol.unh.edu/
        * We need to refactor the bound_for_kernel logic
        * Patrick needs to do a review the v5
   * Patrick to do a review for the tx_offload framework support and the
mbuf_fast_free series
        * https://patchwork.dpdk.org/project/dpdk/list/?series=3D36153
        * Tech board is still discussing the right default behavior for
mbuf_fast_free, which will determine how the testcase should be written

Any other business
      * Next Meeting is Oct 2, 2025

--0000000000008af0eb0640321ba2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>September 18, 2025<br>Attendees<br>=C2=A0 =C2=A01. Patrick R=
obb<br>=C2=A0 =C2=A02. Aaron Conole<br>=C2=A0 =C2=A03. Luca Vizzarro<br>=C2=
=A0 =C2=A04. Sadashiva Rao<br>=C2=A0 =C2=A05. Paul Szczepanek<br>=C2=A0 =C2=
=A06. Aaron Conole<br>=C2=A0 =C2=A0<br>####################################=
#################################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<br>=C2=A0 =C2=
=A0* UNH guys met with governing board about the DTS work this year and pri=
orities going forward in remaining 2025 time and in 2026 (pending next cont=
ract).<br>=C2=A0 =C2=A0* We have published the new DTS instructional videos=
, showing how to setup and run the framework, and how to write a testcase.<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Should produce a part 2 video soon showing=
 some of the minor details like how to use the logger etc.<br>=C2=A0 =C2=A0=
* OvS conference: Call for papers now, ending Monday<br>CI Status<br><br>--=
-------------------------------------------------------------------<br>AWS =
Lab<br>=C2=A0 =C2=A0* None<br>=C2=A0 =C2=A0<br>----------------------------=
-----------------------------------------<br>UNH-IOL Community Lab<br>=C2=
=A0 =C2=A0* PW-CI: Working on standing up an instance of pw-ci, so we can s=
tart to poll for some patches and better understand if this can be used in =
our lab<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Adam made a graphic about how pw-c=
i works and sent it to Aaron to see whether our understanding is correct<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * It could also be committed to the repo if th=
at was considered a value<br>=C2=A0 =C2=A0* DTS:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 * Mlx5_core: A patch has been merged which changes how the device re=
ports MTU, causing the MTU DTS testsuite to fail. Patrick needs to check wh=
at the issue is and send the info to the submitter.<br>=C2=A0 =C2=A0* Sadas=
hiva asked what platforms/tests are being run at the community lab:<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 * Intel i40e and ice testing:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * Performance:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Si=
ngle core forwarding test<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Functional testi=
ng:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Various ethdev tests fou=
nd in <a href=3D"https://git.dpdk.org/tools/dts/tree/tests">https://git.dpd=
k.org/tools/dts/tree/tests</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Cryptodev t=
esting:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Still using legacy D=
TS for this<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Patrick to send a summary to S=
atashiva for Intel based testing at the Community Lab<br><br>--------------=
-------------------------------------------------------<br>Intel Lab<br>=C2=
=A0 =C2=A0* None<br><br>---------------------------------------------------=
------------------<br>Github Actions Robot<br>=C2=A0 =C2=A0* Aaron has sent=
 out to a few CI people an initial patch porting pw-ci over to Python.<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Adam and Patrick from UNH will do a review<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Coderabbit and <a href=3D"http://sourcery.ai=
">sourcery.ai</a>:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Reporting=
 into DPDK patchwork<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Consensus from tech b=
oard is that it is sometimes catching issues, but also making a lot of =E2=
=80=9Cnoise.=E2=80=9D Unclear whether it is a positive or negative value.<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Possibly going to disable cod=
erabbit for now and enable a competing system.<br><br>---------------------=
------------------------------------------------<br>Loongson Lab<br>=C2=A0 =
=C2=A0* None<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Development<br>=C2=A0 =C2=A0=
* Aaron=E2=80=99s AI CI systems are sending some reviews for DTS patches:<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://github.com/ovsrobot/dpdk=
/pull/49">https://github.com/ovsrobot/dpdk/pull/49</a><br>=C2=A0 =C2=A0* DT=
S API Series:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Looks good. Patrick to merge=
.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Want to ensure that there are no bugs in=
troduced to testsuites through this patch. UNH guys to run testing on our h=
ardware.<br>=C2=A0 =C2=A0* Testsuite docs: <a href=3D"https://patchwork.dpd=
k.org/project/dpdk/patch/20250910194259.1027220-2-paul.szczepanek@arm.com/"=
>https://patchwork.dpdk.org/project/dpdk/patch/20250910194259.1027220-2-pau=
l.szczepanek@arm.com/</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Depends on the A=
PI update series, which is being merged today.<br>=C2=A0 =C2=A0* Virtio tes=
ting: Dean is working on a virtio forwarding testsuite to start<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * Contains virtio testing testcases both with the back=
end vhost in =E2=80=93no-pci mode and also others that have the backend vho=
st forward packets from physical NICs<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * V1 S=
ubmitted.<br>=C2=A0 =C2=A0* Single_core_forwarding<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 * Different drivers require different testpmd flags to optimize perf=
ormance. So, reading SUT node config from get_ctx() and switching testpmd a=
rgs based on this.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Without t=
his change, some NICs will perform below their forwarding baseline<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 * Build args for Intel:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * Intel uses a special flag for the rx descriptor byte=
 size, which would need to be included in the user=E2=80=99s test_run.yaml =
for the SUT to build =E2=80=9Ccorrectly.=E2=80=9D<br>=C2=A0 =C2=A0* <a href=
=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250910122749.8277-1-aba=
iley@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/2025091012=
2749.8277-1-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We ne=
ed to refactor the bound_for_kernel logic<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * =
Patrick needs to do a review the v5<br>=C2=A0 =C2=A0* Patrick to do a revie=
w for the tx_offload framework support and the mbuf_fast_free series<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.org/project/dp=
dk/list/?series=3D36153">https://patchwork.dpdk.org/project/dpdk/list/?seri=
es=3D36153</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Tech board is still discuss=
ing the right default behavior for mbuf_fast_free, which will determine how=
 the testcase should be written<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <br>Any other business<br>=C2=A0 =C2=A0 =C2=A0 * Next Mee=
ting is Oct 2, 2025</div>

--0000000000008af0eb0640321ba2--
