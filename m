Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601D3C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 09:14:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC42E4014F;
	Thu, 20 Feb 2025 10:14:57 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 699FC4014F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 10:14:56 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JICh41020243;
 Thu, 20 Feb 2025 01:14:51 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44vyyumg72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 01:14:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYsBmpUSpcTN6tUOqSJbJiGZcyBDRrjIHHPOJxVLlK4hIW4NkT7qtdXii4N0SFWhP+PgReWKxkV4wDgEHcsArThPxM9HfhCCDIbsP8Vj6CD+YxIVP054+gWt8qedrLQx9nVGnxJEhjCWeCF9r1+oXE1+THyPPQLEe7BVXD5zSI4v5ERMjvKElsxjwIUDCua0PRUkeSvCrvYV/no1tj+dZAt3VZejs83uX/4gz1i1SDPzC5K99hZAuLz/Mp2CLGMEwGFHoAnjAMHYdZNzjvlyrUD8XvE1WYnELOmHNzuVj3s05Z93s4EnEN93umqAIRRaRha4ralpFjkaoj8k3ggKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCWaHkbyrYu1FAN+ixlRE/JGEoXmcIqCTSqRb2aH31I=;
 b=hTpbfsUL3hWHYBxsl4tWMoUUuwX1WpmUpCQq/vBgbrCjbCRY5hUECA54jO0LulGVfCMsljetHWuPMjp6ZyzSrDY3n9ELudUOcyym0tGw0JE/dHoZ3FkzrIatT5aQV8KWm46IvxLJuxLeQ/WZlejlxiE4mtS04FgiE4jmsAFl8OKNbwNGdVfPJXweRslaO6HbuCwwNKGEW/jvIqC75dxDh7zKWSylVSC3L5nIXEcKUIfM6YwPW2FfSgwmJrKK87Yp7NAJsAJ6NjLHoq3BrbnUZRX6hzlwBBg8DpP1yH7dcqh3HdU3bUGdIj4jUdoZ0sKPAA1mCEErbjmQaOfxWOrrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCWaHkbyrYu1FAN+ixlRE/JGEoXmcIqCTSqRb2aH31I=;
 b=TRPBw/y/jlsjLJwdvRZxiYZzgT82T4+brohMn8HyKOaCkcE6dUGuGAV0eYYwcLN8C00W4Z7eqnniOx6tQxpzZNu5/CJ32ERIS4P+lrs9NHRG7LzwBPK3m8L8t+vaGWYNxI2OHZoliEm4Xwhgfu8bgr7bKg+ya3cPzW0olaPdnow=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 IA3PR18MB6334.namprd18.prod.outlook.com (2603:10b6:208:529::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 09:14:02 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:13:59 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Luka Jankovic <luka.jankovic@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>
Subject: RE: [EXTERNAL] [RFC v7 0/4] eventdev: atomic tests to test-eventdev
 app
Thread-Topic: [EXTERNAL] [RFC v7 0/4] eventdev: atomic tests to test-eventdev
 app
Thread-Index: AQHbgtRGur5TIW5HjkWXiWpskC/0b7NP6XTg
Date: Thu, 20 Feb 2025 09:13:58 +0000
Message-ID: <PH0PR18MB4086B7A9603C94434ACA967DDEC42@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <20250219134325.1195531-1-luka.jankovic@ericsson.com>
In-Reply-To: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|IA3PR18MB6334:EE_
x-ms-office365-filtering-correlation-id: c5e7b8da-bafd-4d68-ac15-08dd518ee8ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?75BcBz0HCR1kdpMA2k92xWuCzOVm2n0ArTdku665pqh/nOWy2I9vEBlA59k/?=
 =?us-ascii?Q?n9z0o8+71zJgSMkS7w321uXiynKVbF1TJgVMkv1Tp8LuX3kZIlkvsdEKTpwT?=
 =?us-ascii?Q?VTttV18F/0vMlL46GJBdpdOLwE4OlCM547isbKWsdYBiwr+/lPHbNvVkdHA4?=
 =?us-ascii?Q?IjFWWEsXOz61L1Z7J0L8UAlDX5NdO9fzyFDzbGRPMx37EKESkRdNN7lyO6W/?=
 =?us-ascii?Q?/P80tYCE67crFYprV+xhwyHwG+NWe9kZ46H4KAKi7m+wr6mt4aYZplCzzzu4?=
 =?us-ascii?Q?BIsWd2Q+E8StGWV/65It4KIueHS0UUbyj0SivK7nQXj4R1rbfbV+er2KReFc?=
 =?us-ascii?Q?NV8SxoLRIsCSCleOZvLvkQYPSbChWTJC1jq1v8f8lj/mRwbD9bhjT2qM5cUl?=
 =?us-ascii?Q?K8fl+irPeRI/h2vlN3ueTDJYqxLlnILriwAUD5Fl8rwicSf4QfNXsL5rKKsa?=
 =?us-ascii?Q?j1URpWXZ7yzOhGTDhybv5VTJCTMIlil4vSGJFgvKEs2pthBPLgLNQtIlttmS?=
 =?us-ascii?Q?zwco+nlTXt1JCxSsSsrDUmFrc+NNl4T/76Ru5bBIjK+9ekJgY+fzUMqm6mcG?=
 =?us-ascii?Q?XhdE+583tIpEJY13cvo+8QF5mDrDnpW/M+jN9+5NhExvd+Zh2vCJAX/nC+PA?=
 =?us-ascii?Q?uUDxdslnJrP5es3DSsmhUrV9Pv4pLraXyMfIq8ix5abNZ9fCJ5ceGFAikj7h?=
 =?us-ascii?Q?Q8NwrvwyxKWgx7uKUoeUUyazJby00gePn970f6UwBadNJboTsv3uMjSY1e2f?=
 =?us-ascii?Q?inMj2o6dK/cm2818ISGNwMbVLetFCZcGvQvYOnzdpUD6a1hY/yyK2yOVpHvM?=
 =?us-ascii?Q?R4xnxkUd2nIKd4K4zYOfCkNxxisDJd9xxJ/L6XoN0DVQqifzxfSBDusHLYsv?=
 =?us-ascii?Q?C/tmbc2OszGBCCto17IGPQHpKL/RW3w2S/VZs1igr0V1b10xH/dscDThAhop?=
 =?us-ascii?Q?JXTbqli+1GGlFygPIuWW7CCeyqlJlWMHeWSf6soEYUc+D2T5RzCr9A8Y0q1R?=
 =?us-ascii?Q?R1zxESytlKyCWB7+zZWwaT6HciqYh9qRNuk8fm4tKcJzgUffeF1q5ZwestzT?=
 =?us-ascii?Q?EZ6R46448ikqfojjNqFnF9TN3QshkyFvD5ltNVc4vvxaAXtVSXkGLXeyAO57?=
 =?us-ascii?Q?GCtMtRFgQwKqrcwCniItkAqGW9XhmBKdXjHWQvd71Z/KbGEY75xx4DjuRUOr?=
 =?us-ascii?Q?TZCWzP08h74KWEEc90IfsYbwB9u20GgI1n6BzaUAG7tmxFEa+ZnluI0Nu5Hz?=
 =?us-ascii?Q?xxMqG/ICYJN8WeUXM94n1FSHnGfceXNl89RZL3xwhmdsmp70WpnsWzeW/Ncs?=
 =?us-ascii?Q?D3XCr6v3hKCjf7gGgV1jYL9URYmKsWyhqMJYwKk7ppqaShr8cYy9sWKb6S7b?=
 =?us-ascii?Q?mbeSUL8lYdpqjYftCQdJpY/s5Ui6tV23DDAfnGaAz+xjskko+3ynfVF/WR/2?=
 =?us-ascii?Q?Q+hgR+vu26vM5jxP0+b+3yswoqEbN4c5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnY9g5u5Yr7cm1I77Guw6NmipCdFIfULtrBDjCBzCsQULnPrWLN6HopVIddl?=
 =?us-ascii?Q?hRR/nDjV3RgT3cVpgGNOlRGJD7nYG8uOVP7OHEyGVvn+FgCvWbPiFNfUZs6+?=
 =?us-ascii?Q?fqY4E38P/jNbo+WseID/IxGwliB2T598K23HYDHiKJlyoRZx2ZypRQsbrNjo?=
 =?us-ascii?Q?CxmLp36e9tMgA9Ti1HPD+W4Ztl/nNQ66dQa2aACDkdP2l5dHYGAU7dAmzhD8?=
 =?us-ascii?Q?cgnaGXHgVQv8ZmAUBuLq6Qu5VrKQAWXqNNai98KJc9UGzg7EfqJ8mlLgHK9R?=
 =?us-ascii?Q?dNdulL4rMKB+1XglQdfTX3O9QACi0W6177qursbX4GATEoOos6f9cjRdOtFw?=
 =?us-ascii?Q?Hg5sWqaetkMJBcVVXQnEvz72h3hGdF5D4yiEDXv5xm9TTWCTRuyfGYvZVmBt?=
 =?us-ascii?Q?TxmOi01m+AiS09IyvfsN9IZYmAyKEFOfMgkVez3nSWbq7D3yLiZlBhEPylKa?=
 =?us-ascii?Q?STcooe1HZfabN28GgW/MefD1xMhaQ4fiO1TA3mtJPveaW/OGXGlgatoMG2fY?=
 =?us-ascii?Q?zjyc40A1ErZW/DDPbAe8TBeOTQHNfawXIw5R+euDOCurMAZziVTyNYvF7efa?=
 =?us-ascii?Q?zKtaOTK7UtNOyl5+y8AQlbpcXPFNQSooi86Tvpkih6yqeASuBrV60tSvWxvc?=
 =?us-ascii?Q?CJfVTQZzcGfG7GrU61E+FbV26emoVghIrotKzOZyPu6Kcz3juTU+Mkv2uIIP?=
 =?us-ascii?Q?Ap1TLqPOwEIxNvw9EqudqpdCopO3QRzGdlP3nj1RELBw9Vf8akBPE+PJbhLR?=
 =?us-ascii?Q?WyZhEbB1T+Yo6d7WDPydtSl/h1Lbk8wlZHVv/GOow5WxBCNO4gtwDHX7GAw7?=
 =?us-ascii?Q?6f6G0Sqrwl0EL94JG0bBWgMd2476KdZm2McBBrCC/+43hLcMxTdLfSoFjBZY?=
 =?us-ascii?Q?toZQz8yaUxKNn8ipv7T0o8B/NobOq4maHdzsk3BemBzRjVjmpCDYSWTv/Z9f?=
 =?us-ascii?Q?G3k2bXKBzTFJGg4vwTN9DoM/vO3Asv/tQ9Ss5a5iziRpsAUhXbZ8A+4MWjW+?=
 =?us-ascii?Q?GQ5jFWBig6lsLM2qTroduzFryKqMfu1jtDkVKG3UBRYHUXQ1BBPGzwMJEY1Q?=
 =?us-ascii?Q?82rvHnjbnOBUI0ryRxKTAmRkJBDTh/pRo9A3TV/Y7xe7axPeU7/KT0JCvjlx?=
 =?us-ascii?Q?PTanaDE5JwgqBA87XKpa70x8H9400HitRXE+iAjIO7S50lsrvXvklwMIZzSZ?=
 =?us-ascii?Q?StUtYcuOqzoz8nyan8h+34ceRlNvOl4tmKW3P7QUPGOuhwQEusXkYJmeHZjS?=
 =?us-ascii?Q?S3mb98UPu7XNQAvUUbd8g0wzplOi/k8euz7/ALxlbV33UyAGXtFWFnLW1S37?=
 =?us-ascii?Q?Ys0BiMDGc2HDe3F8BCXIi8/6fnhfWxB/57B2IPlQFbUtCBScCOQUCW/MsShv?=
 =?us-ascii?Q?iOVEhpUCyp+1pLR6+MX6D4lr6xk1wzV4WDXwmJah/DbDv871Xhv3FsyPSZIL?=
 =?us-ascii?Q?pXRrwY2HGzz/SVuhyVrm4MLAnB2UbLl0YBhSp6rXYGyGF9nvCH1CJ3tFigOU?=
 =?us-ascii?Q?VQJEUHnIoA42YnCsO3CUbVplVBAs9CD82SmfwBgWl0UnyUr0ZVJ8J15g5Xcb?=
 =?us-ascii?Q?CM7JuH2IYYdZMeha1XSFcr9+jU2SG65fbBY90kdy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e7b8da-bafd-4d68-ac15-08dd518ee8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 09:13:58.9194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CeRMFejLmPvLOD3y5VwyZ1mK2SgvuyPM04cUdPywuuLyYKBXhMXG4IPVxGGjKnjjNBm012G/p1bH2FQTdF0j7vq3rarr0+p9mOUNk5WSSzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6334
X-Proofpoint-GUID: Isly3v_HEXz2YN-aHlNeKjahH1bXHQeU
X-Proofpoint-ORIG-GUID: Isly3v_HEXz2YN-aHlNeKjahH1bXHQeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
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

> Add atomic tests to the test-eventdev app which correspond to the order
> tests but use exclusively atomic queues.
>=20
> The test detects if port maintenance is required, and so they are compati=
ble
> with event devices such as the distributed software eventdev.
>=20
> To verify atomicity, a spinlock is used for each combination of stage and=
 flow.
> It is acquired whenever an event is dequeued for processing and released
> when
> processing is finished.
>=20
> The tests will fail if a port attempts to acquire a lock which is already=
 held.
>=20
> Luka Jankovic (4):
>   eventdev: atomic common for test-eventdev app
>   eventdev: add atomic queue test to test-evnetdev app
>   eventdev: add atomic atq to test-eventdev app
>   eventdev: documentation for atomic queue and atomic atq tests
>=20

Series-tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

>  app/test-eventdev/evt_common.h                |    9 +
>  app/test-eventdev/meson.build                 |    3 +
>  app/test-eventdev/test_atomic_atq.c           |  216 +++
>  app/test-eventdev/test_atomic_common.c        |  134 ++
>  app/test-eventdev/test_atomic_common.h        |   85 +
>  app/test-eventdev/test_atomic_queue.c         |  230 +++
>  .../tools/img/eventdev_atomic_atq_test.svg    | 1588 +++++++++++++++
>  .../tools/img/eventdev_atomic_queue_test.svg  | 1701
> +++++++++++++++++
>  doc/guides/tools/testeventdev.rst             |  155 ++
>  9 files changed, 4121 insertions(+)
>  create mode 100644 app/test-eventdev/test_atomic_atq.c
>  create mode 100644 app/test-eventdev/test_atomic_common.c
>  create mode 100644 app/test-eventdev/test_atomic_common.h
>  create mode 100644 app/test-eventdev/test_atomic_queue.c
>  create mode 100644 doc/guides/tools/img/eventdev_atomic_atq_test.svg
>  create mode 100644
> doc/guides/tools/img/eventdev_atomic_queue_test.svg
>=20
> ---
> v7:
>  * Refactor common atomic test functionality into separate common file.
>  * Implement atomic atq
>=20
> v6:
>  * Revert the use of event.u64 to mbufs as the Marvell CNXK platform
> assumes
>    event.u64 to be 8-byte aligned, which causes the test to fail.
>  * Clarified deadlock error message.
>=20
> v5:
>  * Updated documentation for dpdk-test-eventdev
>=20
> v4:
>  * Fix code style issues.
>  * Remove unused imports.
>=20
> v3:
>  * Use struct to avoid bit operations when accessing event u64.
>  * Changed __rte_always_inline to inline for processing stages.
>  * Introduce idle timeout constant.
>  * Formatting and cleanup.
>=20
> v2:
>  * Changed to only check queue, flow combination, not port, queue, flow.
>  * Lock is only held when a packet is processed.
>  * Utilize event u64 instead of mbuf.
>  * General cleanup.
>=20
> ---
> 2.34.1

