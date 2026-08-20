Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAB7C5DF82
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 09:52:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0809540150;
	Thu, 20 Aug 2026 11:52:22 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id B625B400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 11:52:19 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 207E214000BA;
 Thu, 20 Aug 2026 05:52:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 05:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1787219539; x=1787305939; bh=kgj56AkCCV
 KkjRL/vvncu11E344vsilZYhLoqHjaJn8=; b=YdNRY5kZWgdTd/c8Va2sPyjVXZ
 YOAV6lRvmb2VF1pYUIvwQ90GABHrv4OlfzuCB3ig8PzI9lhBshmKYuwUJKIh9hH+
 EfO+fv8RLYO1DgiUTC2fIJnfBEmU90DudOMakwywp7EmI6qX9bcNJad+iMgemlrx
 jxbOuPxPNoXDOdBYYzxbu4CsSybNxQ9WOPVZQskqN9B49y8YdONd4L7HkBRlYff3
 4QbJp6/lwGWHP3bezo6bM7mvBjC6xstwlpENZFMS2Iu7pMxvws38EBbfqM21WYw4
 od7BVRaBLbL6hfAjHBK3AgDobhPgzmUofJCv5wI9mU1Ev2W06afTp7F8PA/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1787219539; x=1787305939; bh=kgj56AkCCVKkjRL/vvncu11E344vsilZYhL
 oqHjaJn8=; b=khAUfABwZGMjF4dMzHY0JogbEPNYomE3mwp1ML2VE2o0oaWp/s7
 J61tngP8TPgJ1lJ8HV9aoWao9tvginyZn4xCe4o6ynaD0yOGj+MYZqee/DhxdTi+
 D6lwAUEysmX+LLrm3rdpmA1FYPlJje6xAaQPgwCxtP6Jc2rkhfha8VYIB80X8j1W
 SiVXdo8g6VZdehJkrRNujlsI39MoRC8EwP/Clw6fG79uNt9uyY0wtDXRBSX/kRuu
 nckXysnZ0ttKcqkQodOEVtRVGDJIj4pIHV23dHL4U3Xp2BRQJTs8PyD3diaW8p2w
 av6SQjC7tq3bgUqdplzeOKuwh9P0342KDbA==
X-ME-Sender: <xms:Us6GakqMdEmi9H8OpDSov6egGCMF3bHoqLOeA0iTXE9PjA8-bl3GRQ>
 <xme:Us6GagjJf--d7titE_ZRnxDVLUnsRADLWihHGWfhI-NBjr5nLVRDCZSCu3eHJn0RT
 UPHAEK5hjRtFSyHqEWNMeI4jRyTlgzm707e130MkMJs9lErcn63_EI>
X-ME-Received: <xmr:Us6GakSVFhSAckB6K7BKnp6BCsA-zQ6P1S1hDZ2ntdaCuLvhn2wjCQLIiSmXbaGC>
X-ME-Proxy-Cause: dmFkZTFdP0pVo+Cycr6+tIh0doZcGzmmubVMq44fWG4GL6KLjSRWMiKZVPClp9dm58otZ6
 G0UZH0GjF/5ExSfvOBvlfaCVgCEfzV3HMqUEnHlwFBBKSl62VlsIUJW1Y0cRnkKRzs3psf
 aDj2ViAh6tXzbfaFT2UWDYAgYM2ptPXTVpzfO3yNDhfzTw5PYykLeDt8im1GvG/zTCXX/X
 4pUvedGQVnlH8QZF+HZ4QxVP4wKmye/ZpqlGFbFMqIxDX7ukNb6ANxd2t4OP5yCW5dI/bP
 S5ruXbI4V5AjGEf/W6h1tXvogenv9YE7UoTjRVl+sdWMu58Elma+j5o7X1c/yvz6tkWeoV
 XoHqS/NLSrbFi1Je1eI2sgwFwC9McKEy814Xz2dkOkdSbUJaiqtCrjXsP5mKpUwmiFimGm
 8jzI+VOF63YfopDKZ3G6nrF8IggmSxPpvdmOZhh7gZoSnGaOs/Qee4zQmV9p6GRcaEWvsD
 jQ5ZGyugNc6RHVOl1hFZ0z0hmJe1PB0s2o7qnwXye9e+03W2wzDZ9qxg09pHi012KPcAu1
 9/XUAB2rAXKKfV0fdPuKT3mEYw8FzMmUJvXafnQSpaPExdh07SEKgww5K1YXBHtsoBxeJy
 dCSE8MCpChwyhCyf69YT8Y5CmmM6oiGpeKN/QJ9fwlGK3ElgYCSGeJYL6GaA
X-ME-Proxy: <xmx:Us6Gaou6CBGX8RN2KF4lWMudzbrTV_IQlVOQeqVbmTUUZ2HJqp2fWg>
 <xmx:Us6Gane6lha3tJzM8uZ3AuiHrpgORvbdX_TCTxu9tphsyI829NfZFA>
 <xmx:Us6GatLP3Ym3sShZH4oI3_wMxWGUuJLIgdLmOsYjLr59cHkMQlF3Vg>
 <xmx:Us6GatYd5U78PySbjomtRUsrV2tenc_N6cCqvopS7ZJLs7BVgrYB_w>
 <xmx:U86GamYbUI2-EHI-itX58VsknGmKKRiLbf2ELukWR7ZY7aqJURT7TLuF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Thu, 20 Aug 2026 05:52:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Minutes of DPDK Technical Board Meeting, 2026-07-08
Date: Thu, 20 Aug 2026 11:52:17 +0200
Message-ID: <BSRP-D5wSaeJaTYH_K8E1A@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Members Attending: 7/10
	- Aaron Conole
	- Bruce Richardson
	- Hemant Agrawal
	- Jerin Jacob
	- Kevin Traynor
	- Konstantin Ananyev
	- Thomas Monjalon (Chair)

NOTE: The Technical Board meetings take place every second Wednesday at 3 p=
m UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?passwo=
rd=3Dd808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on July 22 and will be chaired by Morten Br=C3=
=B8rup.


1/ EAL initialization

Bruce is working on patches published as RFC in April:
https://patches.dpdk.org/project/dpdk/cover/20260429165845.2136843-1-bruce.=
richardson@intel.com/

The patches are improving how configuration is stored in EAL.
It may help to better split EAL.
And the goal is to initialize EAL without argc/argv.

There are many parameters and we must keep compatibility with the existing =
API.

It is a call for review and give high level feedbacks
like is it worth refactoring? how the interface should look like?


2/ UNH lab CI coverage

Lincoln asked what to present in coverage reports
regarding specific NIC drivers:

https://mails.dpdk.org/archives/dev/2026-June/339545.html

Considering the limited number of NICs in the lab at the moment,
it's probably better to start small and focus on the libraries coverage.
If some NICs help to cover more library features, we could combine them.


