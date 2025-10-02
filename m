Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E24CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 19:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A57F940BA6;
	Thu,  2 Oct 2025 21:58:31 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id C59814042E
 for <dev@dpdk.org>; Thu,  2 Oct 2025 21:58:29 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-27c369f898fso15069975ad.3
 for <dev@dpdk.org>; Thu, 02 Oct 2025 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759435109; x=1760039909; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wE+fSG5OYJF09Yf7G6DCRYYzWRIPFT3S/fE1qgV2f2s=;
 b=D4dWnIPs9gjYnAuGvWHRmWowiFUDdkPqxLS/H9a+FOFQgOCUy8M+bTS/Ddu9FM8dm5
 Wh1hm0T23D4XoLtAHxJhlNDXBVL4vbV2ljV4SpS/MEPDv98TazlI34WW0d94faaI1nD4
 tLq8i3avale3FKk+kagqPv4ERYWahtIC3NmqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435109; x=1760039909;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wE+fSG5OYJF09Yf7G6DCRYYzWRIPFT3S/fE1qgV2f2s=;
 b=P+ZYK1GQ/WuQ6LHqu7WEOj1Xa4ox7haBBy6hopEjkwwwbaE4CWEAmH9QZAbYFYZMo+
 j0E9yEoEHy2Bmt4rDMuGS8hSeJWLsopdWQMFgP4nIndoFVt+vIJww4TL6mq8cjVkEjmB
 og28Z+1EYDt5PURwig9VYCeErknjlTg9hmyxesCwS0KveCr4mTgsGz967HNuEdZv2vSC
 cjcXetADcfYfxBfYi3HOkYVBEcgIdkDZyKzO8BZ0HEBeJIxsCBFtZSJUpm2kM0u6Sexl
 xpXWrEExcoTVjC+HqAnSuxoAefAL2eWZXyKXPZ0nfKKWFt54pODZo5GCb6DLVwOiNrZM
 KM6g==
X-Gm-Message-State: AOJu0Ywwq/u//VaX8KG0MKDHukHxoEize8QpBwAlx7QkyyHkzUi9g1r9
 RxN8wvNpufkq3ZVw3yxn34lfjENimzvYtmsFOaukESx+jwLUSBaL8wy9fDwuIrsyTOXZ5T26KPl
 SJIX1OvV0jQPX9DfQFOii+DV0Ojz22n5zAW2Dg4cboihTdwk3fwn4ECKVGg==
X-Gm-Gg: ASbGncv57iUNg7qDYxKmzLx3CPLfk6RVlSiKIVdacQuOin7E7QYaM1FKmnSjjvIJthg
 AM1Om86pfV1CXcm+mmNUfAOhulVJ0ix4DFgER43c64tEJD0967mTqyy0v/ynDH46tTcfV8Wf9dx
 ypuBN5OG5fZQrGzR1HulvX5eqcpBiTgzkOk/vc5LAqPShUX/RYpDguPlj/tNj+maFJ/Cb6CvtMk
 Sslvat7RWhUoeRPH+HTaSITOyP+oaVjvEdGEWd5fhHfUOWOBx/gphl4jY54MIGz
X-Google-Smtp-Source: AGHT+IFt27sMUCxoDKWEit2GxosAvBf9N/LqMY3fzfdstmJuCCcvlTWtYVqyPI9WbeKObE9vY2CWlShcN/DVzvud3hw=
X-Received: by 2002:a17:902:f642:b0:288:e2ec:edfd with SMTP id
 d9443c01a7336-28e9a5616ccmr4678005ad.10.1759435108567; Thu, 02 Oct 2025
 12:58:28 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Oct 2025 15:57:57 -0400
X-Gm-Features: AS18NWAVEk6bi5DmJpZdNA03bXD7c4eBaalbJlHTjPnMl0VLUnbzMr3NKk6pvF4
Message-ID: <CAJvnSUD=XxjmYP7rXwZgPNijvoeS3X9_YJopJxgsf9Lad5rggw@mail.gmail.com>
Subject: DTS WG Meeting Minutes - September 25, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a6dba606403268c6"
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

--000000000000a6dba606403268c6
Content-Type: text/plain; charset="UTF-8"

####################################################################
September 25, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Andrew Bailey
* Paul Szczepanek
* Indira K

####################################################################
Minutes

=====================================================================
General Discussion
* DTS Videos links:
   * How to set up and run DTS:
https://www.youtube.com/watch?v=vxii8pboNAI&pp=ygUHdW5oIGlvbA%3D%3D
   * How to write a testsuite:
https://www.youtube.com/watch?v=3w9XrYtTvqE&pp=ygUHdW5oIGlvbA%3D%3D

=====================================================================
Patch discussions
* Recently merged:
   * DTS API
   * Testsuite Docstrings update
   * TG Driver Bind
* RSS:
   * Dean is currently testing/reviewing
* Mbuf fast release testcase / tx_offload:
   * Framework changes look to be almost done.
* Virtio:
   * V1 is sent
   * Patrick Robb to do a test/review
* Single_core_fwd_perf:
   * Need to rebase on main before submitting the next version because of
the DTS API patch
   * Need to ensure the docstrings are compliant with the current
testsuites docstring structure
* Move testsuite methods to API modules
   * Patrick to do a review

=====================================================================
Bugzilla discussions
* None

=====================================================================
Any other business
* Roadmap status review:
   *
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=t.0
   * Paul notes for next release we should implement an API freeze for DTS
* Next meeting is Oct 9, 2025
* We are still inheriting from TestSuite, which is an internal framework
object which should not be imported. Maybe the most reasonable thing would
be for the API to have a class/interface
   * Add a TestSuite class to API which inherits from protocol, with set up
test suite, set up test case methods etc.

--000000000000a6dba606403268c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>#####################################################=
###############<br>September 25, 2025<br>Attendees<br>* Patrick Robb<br>* L=
uca Vizzarro<br>* Andrew Bailey<br>* Paul Szczepanek<br>* Indira K</div><di=
v><br></div>###############################################################=
#####<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>General Discussion<br>* DTS Videos links:<br>=C2=A0 =C2=A0* How t=
o set up and run DTS: <a href=3D"https://www.youtube.com/watch?v=3Dvxii8pbo=
NAI&amp;pp=3DygUHdW5oIGlvbA%3D%3D">https://www.youtube.com/watch?v=3Dvxii8p=
boNAI&amp;pp=3DygUHdW5oIGlvbA%3D%3D</a><br>=C2=A0 =C2=A0* How to write a te=
stsuite: <a href=3D"https://www.youtube.com/watch?v=3D3w9XrYtTvqE&amp;pp=3D=
ygUHdW5oIGlvbA%3D%3D">https://www.youtube.com/watch?v=3D3w9XrYtTvqE&amp;pp=
=3DygUHdW5oIGlvbA%3D%3D</a><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* Recently merged:<br>=C2=A0 =C2=
=A0* DTS API<br>=C2=A0 =C2=A0* Testsuite Docstrings update<br>=C2=A0 =C2=A0=
* TG Driver Bind<br>* RSS:<br>=C2=A0 =C2=A0* Dean is currently testing/revi=
ewing<br>* Mbuf fast release testcase / tx_offload: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<br>=C2=A0 =C2=A0* Framework changes look to be almost done.<br>* Vir=
tio:<br>=C2=A0 =C2=A0* V1 is sent<br>=C2=A0 =C2=A0* Patrick Robb to do a te=
st/review<br>* Single_core_fwd_perf:<br>=C2=A0 =C2=A0* Need to rebase on ma=
in before submitting the next version because of the DTS API patch<br>=C2=
=A0 =C2=A0* Need to ensure the docstrings are compliant with the current te=
stsuites docstring structure<br>* Move testsuite methods to API modules<br>=
=C2=A0 =C2=A0* Patrick to do a review<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* None<br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<b=
r>* Roadmap status review:<br>=C2=A0 =C2=A0* <a href=3D"https://docs.google=
.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0=
">https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDB=
Wtxnko/edit?tab=3Dt.0</a><br>=C2=A0 =C2=A0* Paul notes for next release we =
should implement an API freeze for DTS<br>* Next meeting is Oct 9, 2025<br>=
* We are still inheriting from TestSuite, which is an internal framework ob=
ject which should not be imported. Maybe the most reasonable thing would be=
 for the API to have a class/interface <br>=C2=A0 =C2=A0* Add a TestSuite c=
lass to API which inherits from protocol, with set up test suite, set up te=
st case methods etc.<br><br></div>

--000000000000a6dba606403268c6--
