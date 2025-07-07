Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A7BC83030
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 05:46:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 303D34025D;
	Mon,  7 Jul 2025 07:46:41 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by mails.dpdk.org (Postfix) with ESMTP id 9A4DE4021E
 for <dev@dpdk.org>; Mon,  7 Jul 2025 07:46:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1oMEJvzFCWEoVMtFx3EiDDHanu3Bbp5AlOQCPLyQVQDq6xDwMYSI98yN5nN5KJuHhGo+Me4ELIOgfraOhs3Jqp+NemGcLg+GG5i5I97UXRa5cXMpyTPk6f1A2va2ijNQ/m/UGigFyUrw+NoNsNdN7aW3jz6qPa6XAWDWm0Zc6IXpxcUCWkLB/EahWyHJT6FZAyLYdeqgh73wfosibUcPWvwOjkstAH/sKvwvSMlBPG091bnEtZLqbX5Muvr9v5GszReLcouk/2TTMXI7Qf4eaIM1B3Exq9VLDq06fiyCXaRVTMR1jM2z+HQpxfo1bb4HFcvi2vXylhaRfuEPw+W/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1xM4LIw/PSj73JclK5p0lY9amouKpY49UbW+ceNCzo=;
 b=X/zWe6TVBV3ueR2AfRKJqSgcaAWka+c5yrmgyHvW97o/u6hyA8WpKy7TLklqgIwn/Xn72cu0kTM9uHkMVubJvRyrQdam4e3y+hmJ85egEHcuqXyxuosGYPT7vbfuUqfAMwWHPbxak4NLbx3sKvBCDFT+2iWv7m5SGmbbwUfH+QE1SSmlcnKHO80YPN0uxZjaHyKv/sxR95nmAMusRMwgE2Imx1jpbebp6wLeMy0M24De8iSZtUxtb0TJmdSOGSU/9gKp9+3mVOVG8EhdwmxAGVy+lws0NTte9mU2DuE+tPc1hL29hbZhnQAvXXx/5ef3rd45GVuS62EjA7vx6Oq4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1xM4LIw/PSj73JclK5p0lY9amouKpY49UbW+ceNCzo=;
 b=NQ+oosuaavagciqoqKnDEczGka74BRZUiBVBUfqjbp/HwgOT0QJqlTj41JrWHSt/aUC/wRhx3L8w5zRv5MKInAzOXgBkoJvBVmwIlSIjZTLYnNJH9AWtRRpMX8OotnlRriSLFjuFQmeQXM/o62XsKaW/MX0uKk8t3+W6y50DBTlpy2BjVC57w99O5ZvJz+QQEO07mUF87veKpSYWMBJsozyiTqThotOmGR/tmOysQD5aJxeOhGUz+H9OldKjhGpaBHRVRpmzht9VyHMa2y4WBgIxs7+4eIhE5D3FnBKR7OjW106tj86pvJBWehXU4kDgadoQSR6w/WanfCXdZ11jEg==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 05:46:36 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 05:46:36 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Stephen
 Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC PATCH 0/5] Introduce mempool object new debug capabilities
Thread-Topic: [RFC PATCH 0/5] Introduce mempool object new debug capabilities
Thread-Index: AQHb3pBoqDa0br/ndkmHbwmOnhxgILQF6fWAgASMTgCAG9FfMA==
Date: Mon, 7 Jul 2025 05:46:36 +0000
Message-ID: <SA1PR12MB94915F9CB104B4383F1AE01EBF4FA@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250616083009.4a2d69f2@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD14@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD14@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|DM4PR12MB6158:EE_
x-ms-office365-filtering-correlation-id: 48e80487-15e4-4bfe-ede6-08ddbd19a32e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VXIyOGVURFk1Nll0WjJXYis2ai9HdlVuMmVmemFXM2ZZUGdJeWFSUGJlZ1JW?=
 =?utf-8?B?V2ZyZWRqRGwvYmNKMGR4bFBacERaZEdIR1JVb2JEZ01xelZIdmlTcUsvejl4?=
 =?utf-8?B?LzRNMUpxWjU2MXZKa2xvYkJjOHdocGRDai9DcnU4TGlUbWxNbGFSQU1KeXhh?=
 =?utf-8?B?ZmlRVUNQVFZhRXk0b2IrWllUQVhRQk9jS3pHSHMyOU1GOVNFRFdDL0Q4dWEy?=
 =?utf-8?B?eXJDbXJxQ1pzOHhDTGpQOEpSWFNRcjBORk54T29MQzhveGVnc2k3NzBXQmow?=
 =?utf-8?B?bUlQYzgvaU82eThsL3BYSC9tcTFIb2RCZUZSaDNEN0lSVm84eHpCQjZOVG16?=
 =?utf-8?B?cVBZK3FVVDl3LzhHbFhzWTVpL01Hc2lKaDliYVo1R0VreWxBNjZKS1NGaFl0?=
 =?utf-8?B?ZDdQM3IyRHJJT0h4K24wQ1J0T01GNjZVTTJPZlpZalB0M3JFRkQ1N3AyZWJ3?=
 =?utf-8?B?VWIzM1pYODdrUTJlWHh6czBkRjVKYVozL0Y2L1JqKzJRT3F2eTRwSnhPV3Ja?=
 =?utf-8?B?Q2JYQ0tIN3phcHdKMmlHUFQxVHpFWGh1VW1nUlJYVFdtOHQ1MFFueHZKZ3Fw?=
 =?utf-8?B?dU42WGJzR2ZLbnJZTTRyZHNpU1psSnFNYy9aYXJBYnlld01DVkhsSUZ2RnFl?=
 =?utf-8?B?cHVyZUVlaGNpVitNMEcxWlJiVVFHRGJYQnVhUHl6cGRBRUJ6T3NEekpMVVY1?=
 =?utf-8?B?SlV2MU5xRnozSmhNS2RXcERjVXRjWHpKamVoenNmd24wdTlCb3Z2VnlOVVYx?=
 =?utf-8?B?ak1NKzlxdUpoa3NBLzk5bG1ka0dCTnN0Q0NLWGE3TlBsYkZkenJMcjdZWUxK?=
 =?utf-8?B?azdIbWhXbkZtY3QxR0Rqb2VUT1VXRjh0bms0cll4ekVudFFra21VRFppNmJ1?=
 =?utf-8?B?UXBXY09KeU9qN3c4THVlN3h5YkpXeEdROS96Z3F3dmlRZkY4M1FPaVg0RzRh?=
 =?utf-8?B?b3VIZVNjYm9uWjAzL29nc2JocFN4LzhNaGU3azNnaHpmd1NvNlJlUEFQSjFl?=
 =?utf-8?B?em9pMS81SmlseStjeERCb1QvK1hsRENBZlhPeDZiYkd5SUEvc2NzSW8zZitM?=
 =?utf-8?B?bjZ4aWFoOXZtLzk2WDVub09CZkliUXozYzBySXpuZ3ZZb3BLckxTdExWUDJl?=
 =?utf-8?B?NGFxcFJNZHpzNW1NaW1LQUlwTnozbmJKcjNjVlFwaUoyRUhkN0ZGQzFYTEsv?=
 =?utf-8?B?SGZCVEQ3MnZTM1BhUXVMRFBQbWhUMmdIRTBTdzdQWTlyVk1Pc2lWOFBzTWVW?=
 =?utf-8?B?enpxMHhLbkhGbFQ1cWxuQ09lYmN0aTJwckdwNUw1bXJXcENkblk4NzFHQ3ds?=
 =?utf-8?B?R1V0WXoxVEtHb3Avbm1pM3gyTG9GVzhSWGladzRRMFhxR2hIUngzNEpHdFR0?=
 =?utf-8?B?bTNjVjVXaGp4cXZpNldCTGszaGhjQU1aSWczdnRwcVUzYzdTSndZSmFKUVdD?=
 =?utf-8?B?TkpidStYY2pERWJUMHJiS2VidjYrK1k1TTNqNzVheXJpU1FJeWdkUW9ibjBY?=
 =?utf-8?B?OFZYUXFNMjE5QWx6YndyMWJqTDE0dzFWazJxKzFXQWhneU56TURuYkcyNis4?=
 =?utf-8?B?Tkl5UFVVMXVPODlxeUZuUUFRYWliMzZwQlF3QWxCZHlTSEtrN2daTXFnS1c2?=
 =?utf-8?B?RUp5RHRqdVYvL2ZidzhmSHFwQW56eXBGK2o4ZUVLdDIwMXlzWUkzOEM3Vy9R?=
 =?utf-8?B?RG93bDZHUFhvYS9LeGN2OTk1K2hHRTJMNTZnQ2w2bndrc1JVUjlNUmlHMkJh?=
 =?utf-8?B?ZnVMYy83YXJQNVZuRGFhT2ZMYlNtRzd6K2NGT2lZNzZJUVVHUlpZaDFmMmx0?=
 =?utf-8?B?SnljTXcxK2p1T0E3YUJmMklUZXhEeWRzY2RGTjg2MTFuR1dXclkwRXZMODhq?=
 =?utf-8?B?cldYVStiUi82VEZ3dDhHSVk1ZldHdU15UkFvbXRpU1JoWHlqUmt6alplNlo3?=
 =?utf-8?B?SlJnUkJXSDhSNi9hUW5lZEhMbmFzMlNyMmk0Y3RkY1V3VTl5eklmRi8vMm1V?=
 =?utf-8?B?ckFHaTdQa1d3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk80YnlmZWw5NzZES09YNC9UTzRWa3RQa25PT3RFSkpMSWxSZEF6NlVSTk9V?=
 =?utf-8?B?empxNTlWa21wcjllUVUxWjB4dVNXUE1sR1RuVHNqcU03dERlUHFuTzV1MHJH?=
 =?utf-8?B?eHpkdThDRXU1Z2hFZHROQ2t3NjhEdTFoaUJDeHB2VGVlay9ITFNMTEMwQnlm?=
 =?utf-8?B?RDdvWlhiTXJFelpRV2ZWbUdDb1RlVEtkVE5EODVSVUxvemZFVS9FUC91bnA5?=
 =?utf-8?B?L3pONm5WZzFwUVYvWGVFMGJQbUxLeTBYWjkyRDNQS2F4SFpySUdGelB2L0FC?=
 =?utf-8?B?WnJ6VkdSL1ArdDFEY2FndTJjY1NCQzlxbVJlU2JKOVFsZllOQ2M2RG0rNlN3?=
 =?utf-8?B?VWlUMEphN3JYejJOVHVkNlp4QjNCaDRqSXEwN085VTVxbm9Yb3JNdnUvQk5V?=
 =?utf-8?B?MzJ3c3ZZbW1WQk1GSW5qU0hVN09XOUxKL2cxVE5rSEF2emExVnpMYm1MOHVL?=
 =?utf-8?B?UzRaQzBMV1p3TWF5Mm5rK1JuVVpWZS9ZNmxpeGVuWURqRXZoSTZhTnNsQmFj?=
 =?utf-8?B?TFBWK3ZhUi9rWFAzb1phN0lrUkxSVlh3TmJSRkVqY0tUWWVKMkJrcGNOSXVN?=
 =?utf-8?B?aHhOUU5DRjBwZTZUWU5vY0tGRWVXT2o5eGRHdWpIamZLMDlWNFZBcGdDT2tK?=
 =?utf-8?B?b3RvVEhhOS92SDZQQ2NRT2Z2RW9UeWhSLzhIaEVVamw2bXpNa1NtbnBZRWRy?=
 =?utf-8?B?eVdlZjU3TGUrNVlUeHZQVVk4ZDlMRU91OEFpT01zZ2ZzS3NidGxKc0k4ckds?=
 =?utf-8?B?VnY0aHhRaklJMkpoQVoya1F5QzlYVDBMTGJaaWtLcVd4Q2RBKzJtWXRXWC9E?=
 =?utf-8?B?NTZ3RkF5Ujl5OXBGQjZhb0xVTml1UnRZNzIwZVVSczR4ZGF5ZmhMMWN3SXo0?=
 =?utf-8?B?Q3ljVUdiMGFDMHZPRElvTGxEc2swZitHMGhDWjltdXRpMlUrSEpZdU9wYWZy?=
 =?utf-8?B?SHNDY2dZL1BLTk5ldUl2N1I5dFZjRnhWOHZ1dTVCempmKzA5UGZKSDJkcXVO?=
 =?utf-8?B?S2JUQ0Qxd0xiaDlIOG5SZlRIb29Nd08yL3Y2ZWdpa3BEZllHWDZVeks4NUlK?=
 =?utf-8?B?UjBKbGJJeVo0MG94MzZaazdHV2s5NEFVU0RpWDB3b2pJNmY4NVhsSzJjanMw?=
 =?utf-8?B?a2w3UC81aVZVMWZ1MGFYRU5zcDFuV2gxakVhdXVYYlY4S051by9QMTFjYTdW?=
 =?utf-8?B?MUxCSUNMNDFoZm5MeTRDU1NXNWFQRnV5VEFmVGJsTDZEcThsaGM2WGtUT0hj?=
 =?utf-8?B?TVFJK01CN0dzdng5UDl3c013bHlRdGQ4VHQ2L1RNVWlkRVR4THNFYWRuRFIx?=
 =?utf-8?B?VWZkemxvQlErU3FGV3BNd1R4WmpwWUZZRnFiZ3RTcTBWM2tFb3JnckdIZjZX?=
 =?utf-8?B?dEdVM1NrNmJiRXNqb1loYWtwVXFuNGNzWS9OUHlvcVAwZVhFTzAzRCswQmV1?=
 =?utf-8?B?a1AwRFI4QU1iSkppV3pQUng0ajI5N005dTZDTWpGdUhFZHpBTEgxSlJHMkJ3?=
 =?utf-8?B?MFN3NW0zTENGS3ZIZThwVi83UzJKU0xUTXM3Q0puSDRJVVNxcnY4MXBoa3JO?=
 =?utf-8?B?Tkx5Y1hZRzFYaXgvZ0l5c1NBdkhvVFhkLzVIbHJoVlZ4R21uT3d0bm1DbHVX?=
 =?utf-8?B?STVPTzg5QmJzS1hndDc0V2VwZXl1ODY5cU91RVJHdGdhVU5PRG1CSFBZbXlP?=
 =?utf-8?B?RWZOQnFmUitRaWdCRUM5bmFLTVIrVjBHeXM2aitlV1Q4K29PWDRkYVkvRWw1?=
 =?utf-8?B?NGR0TE9zRzRtbGFtYzhpUHRuRHFmSjdTUFFtZjFWbzI2VitLUW5XdTRrd2I0?=
 =?utf-8?B?MjFSTjJOU3VrZEFZVDZOeFdIU2cyakJEQ3JGeEpCZTYrOS9SVi9FSGUzaE9P?=
 =?utf-8?B?WUJaL2lPWFp0bHV1QUVaQTFvZEtTVmZubjJaQ3FDaUE4V25HUksrSWxqVnNU?=
 =?utf-8?B?ZytCZXZLL1VGQ21oQkdPcys2aC9uNlEweFRNdGhRMlBzdnFvMzYyL0hCWnd5?=
 =?utf-8?B?ZkZlSTIzc08zVlU3UEIxL01qL21GaWJTampzeXlENVk4Z3RaVDR6UTJyVFhv?=
 =?utf-8?B?YTA5bnRJZ25FaHIwS1pPbzRMNFZwR1dPcU0xaHFRd0VYVnkzRVpPN21rd3dJ?=
 =?utf-8?Q?IGdYmDpCn4ddlFRI1GNns6ozK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e80487-15e4-4bfe-ede6-08ddbd19a32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 05:46:36.5522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtw16Qiui3IEK36+nFXj0kfrY1qAaghP5KkbRNeoApQVa998T34c2fHVOaR5SoAXfhviGRQmKh0WC6OC5ldLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9ydGVuIEJyw7hydXAg
PG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDE5IEp1bmUgMjAy
NSAxNTo1Nw0KPiBUbzogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnPjsgU2hhbmkgUGVyZXR6DQo+IDxzaHBlcmV0ekBudmlkaWEuY29tPg0KPiBDYzogZGV2QGRw
ZGsub3JnDQo+IFN1YmplY3Q6IFJFOiBbUkZDIFBBVENIIDAvNV0gSW50cm9kdWNlIG1lbXBvb2wg
b2JqZWN0IG5ldyBkZWJ1Zw0KPiBjYXBhYmlsaXRpZXMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gPiBGcm9t
OiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnXQ0K
PiA+IFNlbnQ6IE1vbmRheSwgMTYgSnVuZSAyMDI1IDE3LjMwDQo+ID4NCj4gPiBPbiBNb24sIDE2
IEp1biAyMDI1IDEwOjI5OjA1ICswMzAwDQo+ID4gU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlk
aWEuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gVGhpcyBmZWF0dXJlIGlzIGRlc2lnbmVkIHRvIG1v
bml0b3IgdGhlIGxpZmVjeWNsZSBvZiBtZW1wb29sIG9iamVjdHMNCj4gPiA+IGFzIHRoZXkgbW92
ZSBiZXR3ZWVuIHRoZSBhcHBsaWNhdGlvbiBhbmQgdGhlIFBNRC4NCj4gPiA+DQo+ID4gPiBJdCB3
aWxsIGFsbG93IHVzIHRvIHRyYWNrIHRoZSBvcGVyYXRpb25zIGFuZCB0cmFuc2l0aW9ucyBvZiBl
YWNoDQo+ID4gPiBtZW1wb29sIG9iamVjdCB0aHJvdWdob3V0IHRoZSBzeXN0ZW0sIGhlbHBpbmcg
aW4gZGVidWdnaW5nIGFuZA0KPiA+ID4gdW5kZXJzdGFuZGluZyBvYmplY3RzDQo+ID4gZmxvdy4N
Cj4gPiA+DQo+ID4gPiBUaGUgaW1wbGVtZW50YXRpb24gaW5jbHVkZSBzZXZlcmFsIGtleSBjb21w
b25lbnRzOg0KPiA+ID4gMS4gQWRkZWQgYSBiaXRtYXAgdG8gbWVtcG9vbCdzIGhlYWRlciAocnRl
X21lbXBvb2xfb2JqaGRyKQ0KPiA+ID4gICAgdGhhdCByZXByZXNlbnQgdGhlIG9wZXJhdGlvbnMg
aGlzdG9yeS4NCj4gPiA+IDIuIEFkZGVkIGZ1bmN0aW9ucyB0aGF0IGFsbG93IG1hcmtpbmcgb3Bl
cmF0aW9ucyBvbiBhbg0KPiA+ID4gICAgbWVtcG9vbCBvYmplY3RzLg0KPiA+ID4gMy4gRHVtcHMg
dGhlIGhpc3RvcnkgdG8gYSBmaWxlIG9yIHRoZSBjb25zb2xlDQo+ID4gPiAgICAocnRlX21lbXBv
b2xfb2JqZWN0c19kdW1wKS4NCj4gPiA+IDQuIEFkZGVkIHB5dGhvbiBzY3JpcHQgdGhhdCBjYW4g
cGFyc2UsIGFuYWx5emUgdGhlIGRhdGEgYW5kDQo+ID4gPiAgICBwcmVzZW50IGl0IGluIGFuIGh1
bWFuIHJlYWRhYmxlIGZvcm1hdC4NCj4gPiA+IDUuIEFkZGVkIGNvbXBpbGF0aW9uIGZsYWcgdG8g
ZW5hYmxlIHRoZSBmZWF0dXJlLg0KPiA+ID4NCj4gPiA+IFNoYW5pIFBlcmV0eiAoNSk6DQo+ID4g
PiAgIG1lbXBvb2w6IHJlY29yZCBtZW1wb29sIG9iamVjdHMgb3BlcmF0aW9ucyBoaXN0b3J5DQo+
ID4gPiAgIGRyaXZlcnM6IGFkZCBtZW1wb29sIGhpc3RvcnkgY29tcGlsYXRpb24gZmxhZw0KPiA+
ID4gICBuZXQvbWx4NTogbWFyayBhbiBvcGVyYXRpb24gaW4gbWVtcG9vbCBvYmplY3QncyBoaXN0
b3J5DQo+ID4gPiAgIGFwcC90ZXN0cG1kOiBhZGQgdGVzdHBtZCBjb21tYW5kIHRvIGR1bXAgbWVt
cG9vbCBoaXN0b3J5DQo+ID4gPiAgIHVzZXJ0b29sOiBhZGQgYSBzY3JpcHQgdG8gcGFyc2UgbWVt
cG9vbCBoaXN0b3J5IGR1bXANCj4gPiA+DQo+ID4NCj4gPiBDb3VsZCB0aGlzIG5vdCBhbHJlYWR5
IGJlIGRvbmUgd2l0aCB0cmFjaW5nIGluZnJhc3RydWN0dXJlPw0KPiANCj4gSSBhZ3JlZSB3aXRo
IFN0ZXBoZW4gb24gdGhpcy4NCj4gDQo+IEFuZCwgaWYgeW91IHBsYW4gdG8gdXNlIHRoaXMgZm9y
IHBlcmZvcm1hbmNlIG1lYXN1cmVtZW50cywgeW91IGNhbiB1c2UgdGhlDQo+IGNvbWluZyBQTVUg
dHJhY2UgdG8gdHJhY2UgdGhlIG9iamVjdHMnIG1vdmVtZW50cyBiZXR3ZWVuIENQVSBjYWNoZXMg
YW5kDQo+IFJBTSwgc28geW91IGNhbiBkaXNjcmltaW5hdGUgYmV0d2VlbiBob3QgYW5kIGNvbGQg
b2JqZWN0cy4NCg0KV2Ugd2FudCB0byB0cmFjayB3aGVuIHRoZSB0cmFuc2l0aW9uIG9mIG9iamVj
dHMgYmV0d2VlbiB0aGUgYXBwIGFuZCB0aGUgUE1ELiBTbyBJIGRvbid0IGtub3cgaWYgUE1VIGxp
YnJhcnkgaXMgaGVscGZ1bCBpbiB0aGlzIGNhc2UsIGlzbid0IGl0Pw0KDQo=
